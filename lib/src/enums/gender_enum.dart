part of 'enums.dart';

enum Gender { male, female, unknown }

final genderValues = EnumValues(
  {
    "Female": Gender.female,
    "Male": Gender.male,
    "unknown": Gender.unknown,
  },
);
