import 'package:my_app_123/models/patient_record.dart';
import 'package:intl/intl.dart';

extension PatientRecordExtension on PatientRecord {
  String get formattedDate => DateFormat('dd MMM yyyy').format(recordDate);

  String get ageDisplay => '$age years old';

  String get summary => '$name - $condition';

  bool matchesSearch(String query) {
    final lowercaseQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowercaseQuery) ||
        condition.toLowerCase().contains(lowercaseQuery) ||
        notes.toLowerCase().contains(lowercaseQuery);
  }
}
