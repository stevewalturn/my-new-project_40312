import 'package:my_app_123/models/patient_record.dart';

extension PatientRecordExtension on PatientRecord {
  bool matchesSearch(String query) {
    final searchQuery = query.toLowerCase();
    return name.toLowerCase().contains(searchQuery) ||
        condition.toLowerCase().contains(searchQuery) ||
        notes.toLowerCase().contains(searchQuery) ||
        age.toString().contains(searchQuery) ||
        gender.toLowerCase().contains(searchQuery);
  }
}
