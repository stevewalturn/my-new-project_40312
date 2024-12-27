import 'package:equatable/equatable.dart';

class PatientRecord extends Equatable {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String condition;
  final DateTime recordDate;
  final String notes;

  const PatientRecord({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.condition,
    required this.recordDate,
    required this.notes,
  });

  PatientRecord copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? condition,
    DateTime? recordDate,
    String? notes,
  }) {
    return PatientRecord(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      condition: condition ?? this.condition,
      recordDate: recordDate ?? this.recordDate,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'condition': condition,
      'recordDate': recordDate.toIso8601String(),
      'notes': notes,
    };
  }

  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    return PatientRecord(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      condition: json['condition'] as String,
      recordDate: DateTime.parse(json['recordDate'] as String),
      notes: json['notes'] as String,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, age, gender, condition, recordDate, notes];
}
