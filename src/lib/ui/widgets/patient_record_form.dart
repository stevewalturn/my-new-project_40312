import 'package:flutter/material.dart';
import 'package:my_app_123/models/patient_record.dart';
import 'package:my_app_123/ui/common/app_colors.dart';
import 'package:my_app_123/ui/common/ui_helpers.dart';

class PatientRecordForm extends StatefulWidget {
  final PatientRecord? initialRecord;
  final Function(PatientRecord) onSubmit;

  const PatientRecordForm({
    this.initialRecord,
    required this.onSubmit,
    super.key,
  });

  @override
  State<PatientRecordForm> createState() => _PatientRecordFormState();
}

class _PatientRecordFormState extends State<PatientRecordForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _conditionController;
  late TextEditingController _notesController;
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialRecord?.name);
    _ageController =
        TextEditingController(text: widget.initialRecord?.age.toString() ?? '');
    _conditionController =
        TextEditingController(text: widget.initialRecord?.condition);
    _notesController = TextEditingController(text: widget.initialRecord?.notes);
    if (widget.initialRecord != null) {
      _selectedGender = widget.initialRecord!.gender;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _conditionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final record = PatientRecord(
        id: widget.initialRecord?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: _selectedGender,
        condition: _conditionController.text,
        recordDate: DateTime.now(),
        notes: _notesController.text,
      );
      widget.onSubmit(record);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Patient Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter patient name';
              }
              return null;
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter age';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          verticalSpaceSmall,
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
            ),
            items: ['Male', 'Female', 'Other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            controller: _conditionController,
            decoration: const InputDecoration(
              labelText: 'Medical Condition',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter medical condition';
              }
              return null;
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          verticalSpaceMedium,
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: kcPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              widget.initialRecord == null
                  ? 'Add Patient Record'
                  : 'Update Record',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
