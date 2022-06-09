part of 'enums.dart';

enum Gender { male, female, unknown }

extension ExtensionGenderEnum on Gender {
  String get toSpanishString {
    switch (this) {
      case Gender.male:
        return 'Masculino';
      case Gender.female:
        return 'Femenino';
      case Gender.unknown:
        return 'Desconocido';
    }
  }
}

final genderValues = EnumValues(
  {
    "Female": Gender.female,
    "Male": Gender.male,
    "unknown": Gender.unknown,
  },
);
