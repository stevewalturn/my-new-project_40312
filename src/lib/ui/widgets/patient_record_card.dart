import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app_123/models/patient_record.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';

class PatientRecordCard extends StatelessWidget {
  final PatientRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PatientRecordCard({
    required this.record,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    record.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kcPrimaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: kcMediumGrey),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                _InfoItem(
                  label: 'Age',
                  value: record.age.toString(),
                ),
                horizontalSpaceMedium,
                _InfoItem(
                  label: 'Gender',
                  value: record.gender,
                ),
              ],
            ),
            verticalSpaceSmall,
            _InfoItem(
              label: 'Condition',
              value: record.condition,
            ),
            verticalSpaceSmall,
            _InfoItem(
              label: 'Date',
              value: DateFormat('dd MMM yyyy').format(record.recordDate),
            ),
            if (record.notes.isNotEmpty) ...[
              verticalSpaceSmall,
              _InfoItem(
                label: 'Notes',
                value: record.notes,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: kcMediumGrey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
