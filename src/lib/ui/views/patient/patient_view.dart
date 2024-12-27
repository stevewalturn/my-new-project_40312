import 'package:flutter/material.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';
import 'package:my_app_123/ui/views/patient/patient_viewmodel.dart';
import 'package:my_app_123/ui/widgets/patient_record_card.dart';
import 'package:stacked/stacked.dart';

class PatientView extends StackedView<PatientViewModel> {
  const PatientView({super.key});

  @override
  Widget builder(
    BuildContext context,
    PatientViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Records'),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: viewModel.setSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search patients...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                if (viewModel.hasError)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      viewModel.modelError.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                Expanded(
                  child: viewModel.filteredRecords.isEmpty
                      ? Center(
                          child: Text(
                            viewModel.hasRecords
                                ? 'No matching records found'
                                : 'No patient records yet',
                            style: const TextStyle(
                              fontSize: 16,
                              color: kcMediumGrey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: viewModel.filteredRecords.length,
                          itemBuilder: (context, index) {
                            final record = viewModel.filteredRecords[index];
                            return PatientRecordCard(
                              record: record,
                              onEdit: () => viewModel.showEditRecord(record),
                              onDelete: () => viewModel.deleteRecord(record.id),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kcPrimaryColor,
        onPressed: viewModel.showAddRecord,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  PatientViewModel viewModelBuilder(BuildContext context) => PatientViewModel();

  @override
  void onViewModelReady(PatientViewModel viewModel) => viewModel.initialize();
}
