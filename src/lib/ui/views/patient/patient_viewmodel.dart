import 'package:flutter/material.dart';
import 'package:my_app_123/app/app.locator.dart';
import 'package:my_app_123/models/patient_record.dart';
import 'package:my_app_123/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PatientViewModel extends BaseViewModel {
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<PatientRecord> _allRecords = [];
  String _searchQuery = '';

  List<PatientRecord> get filteredRecords => _searchQuery.isEmpty
      ? _allRecords
      : _allRecords
          .where((record) => record.matchesSearch(_searchQuery))
          .toList();

  bool get hasRecords => _allRecords.isNotEmpty;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _allRecords = await _sharedPreferencesService.getPatientRecords();
      rebuildUi();
    } catch (e) {
      setError('Failed to load patient records: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    rebuildUi();
  }

  Future<void> showAddRecord() async {
    final result = await _showRecordDialog();
    if (result != null) {
      await _addRecord(result);
    }
  }

  Future<void> showEditRecord(PatientRecord record) async {
    final result = await _showRecordDialog(record);
    if (result != null) {
      await _updateRecord(result);
    }
  }

  Future<void> deleteRecord(String id) async {
    final shouldDelete = await _dialogService.showDialog(
      title: 'Delete Record',
      description: 'Are you sure you want to delete this record?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (shouldDelete?.confirmed ?? false) {
      setBusy(true);
      try {
        await _sharedPreferencesService.deletePatientRecord(id);
        _allRecords.removeWhere((record) => record.id == id);
        rebuildUi();
      } catch (e) {
        setError('Failed to delete record: ${e.toString()}');
      } finally {
        setBusy(false);
      }
    }
  }

  Future<PatientRecord?> _showRecordDialog(
      [PatientRecord? existingRecord]) async {
    return showDialog<PatientRecord>(
      context: _navigationService.navigatorKey!.currentContext!,
      builder: (context) => Dialog(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                existingRecord == null
                    ? 'Add Patient Record'
                    : 'Edit Patient Record',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              PatientRecordForm(
                initialRecord: existingRecord,
                onSubmit: (record) {
                  Navigator.of(context).pop(record);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addRecord(PatientRecord record) async {
    setBusy(true);
    try {
      await _sharedPreferencesService.addPatientRecord(record);
      _allRecords.add(record);
      rebuildUi();
    } catch (e) {
      setError('Failed to add record: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  Future<void> _updateRecord(PatientRecord record) async {
    setBusy(true);
    try {
      await _sharedPreferencesService.updatePatientRecord(record);
      final index = _allRecords.indexWhere((r) => r.id == record.id);
      if (index != -1) {
        _allRecords[index] = record;
        rebuildUi();
      }
    } catch (e) {
      setError('Failed to update record: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }
}
