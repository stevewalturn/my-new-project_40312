import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app_123/models/patient_record.dart';
import 'package:stacked/stacked.dart';

class SharedPreferencesService with ListenableServiceMixin {
  static const String _patientRecordsKey = 'patient_records';

  Future<void> savePatientRecords(List<PatientRecord> records) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = records.map((record) => record.toJson()).toList();
      await prefs.setString(_patientRecordsKey, jsonEncode(recordsJson));
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to save patient records: ${e.toString()}');
    }
  }

  Future<List<PatientRecord>> getPatientRecords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsString = prefs.getString(_patientRecordsKey);

      if (recordsString == null) {
        return [];
      }

      final recordsList = jsonDecode(recordsString) as List;
      return recordsList
          .map((record) =>
              PatientRecord.fromJson(record as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load patient records: ${e.toString()}');
    }
  }

  Future<void> addPatientRecord(PatientRecord record) async {
    try {
      final records = await getPatientRecords();
      records.add(record);
      await savePatientRecords(records);
    } catch (e) {
      throw Exception('Failed to add patient record: ${e.toString()}');
    }
  }

  Future<void> updatePatientRecord(PatientRecord updatedRecord) async {
    try {
      final records = await getPatientRecords();
      final index =
          records.indexWhere((record) => record.id == updatedRecord.id);

      if (index != -1) {
        records[index] = updatedRecord;
        await savePatientRecords(records);
      } else {
        throw Exception('Patient record not found');
      }
    } catch (e) {
      throw Exception('Failed to update patient record: ${e.toString()}');
    }
  }

  Future<void> deletePatientRecord(String id) async {
    try {
      final records = await getPatientRecords();
      records.removeWhere((record) => record.id == id);
      await savePatientRecords(records);
    } catch (e) {
      throw Exception('Failed to delete patient record: ${e.toString()}');
    }
  }

  Future<void> saveData(String key, dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(value);
      await prefs.setString(key, jsonString);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to save data: ${e.toString()}');
    }
  }

  Future<dynamic> getData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);

      if (jsonString == null) {
        return null;
      }

      return jsonDecode(jsonString);
    } catch (e) {
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }
}
