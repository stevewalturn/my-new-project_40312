import 'package:equatable/equatable.dart';

class Tamagotchi extends Equatable {
  final String id;
  final String name;
  final int hunger;
  final int happiness;
  final int health;
  final DateTime lastFed;
  final DateTime lastPlayed;
  final bool isAlive;

  const Tamagotchi({
    required this.id,
    required this.name,
    required this.hunger,
    required this.happiness,
    required this.health,
    required this.lastFed,
    required this.lastPlayed,
    required this.isAlive,
  });

  Tamagotchi copyWith({
    String? id,
    String? name,
    int? hunger,
    int? happiness,
    int? health,
    DateTime? lastFed,
    DateTime? lastPlayed,
    bool? isAlive,
  }) {
    return Tamagotchi(
      id: id ?? this.id,
      name: name ?? this.name,
      hunger: hunger ?? this.hunger,
      happiness: happiness ?? this.happiness,
      health: health ?? this.health,
      lastFed: lastFed ?? this.lastFed,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      isAlive: isAlive ?? this.isAlive,
    );
  }

  factory Tamagotchi.create(String name) {
    return Tamagotchi(
      id: DateTime.now().toString(),
      name: name,
      hunger: 100,
      happiness: 100,
      health: 100,
      lastFed: DateTime.now(),
      lastPlayed: DateTime.now(),
      isAlive: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hunger': hunger,
      'happiness': happiness,
      'health': health,
      'lastFed': lastFed.toIso8601String(),
      'lastPlayed': lastPlayed.toIso8601String(),
      'isAlive': isAlive,
    };
  }

  factory Tamagotchi.fromJson(Map<String, dynamic> json) {
    return Tamagotchi(
      id: json['id'] as String,
      name: json['name'] as String,
      hunger: json['hunger'] as int,
      happiness: json['happiness'] as int,
      health: json['health'] as int,
      lastFed: DateTime.parse(json['lastFed'] as String),
      lastPlayed: DateTime.parse(json['lastPlayed'] as String),
      isAlive: json['isAlive'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        hunger,
        happiness,
        health,
        lastFed,
        lastPlayed,
        isAlive,
      ];
}
