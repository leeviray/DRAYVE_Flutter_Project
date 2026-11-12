import 'package:flutter/material.dart';

class Circuit {
  final String roundLabel; 
  final String countryFlag; 
  final String countryName; 
  final String raceName; 
  final String dateRange; 
  final String circuitName; 
  final String location;
  final double lengthKm; 
  final int laps; 
  final int turns; 
  final String lapRecord; 
  final int firstGrandPrix; 
  final List<Offset> trackOutline;
  final String? trackMapPath;
  final String? imagePath;

  const Circuit({
    required this.roundLabel,
    required this.countryFlag,
    required this.countryName,
    required this.raceName,
    required this.dateRange,
    required this.circuitName,
    required this.location,
    required this.lengthKm,
    required this.laps,
    required this.turns,
    required this.lapRecord,
    required this.firstGrandPrix,
    required this.trackOutline,
    this.trackMapPath,
    this.imagePath,
  });
}