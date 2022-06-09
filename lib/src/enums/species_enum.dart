part of 'enums.dart';

enum Species { human, alien }

extension ExtensionSpeciesEnum on Species {
  String get toSpanishString {
    switch (this) {
      case Species.human:
        return 'Humano';
      case Species.alien:
        return 'Alien';
    }
  }
}

final speciesValues = EnumValues({
  "Alien": Species.alien,
  "Human": Species.human,
});
