part of 'enums.dart';

enum Status { alive, unknown, dead }

extension ExtensionStatusEnum on Status {
  String get toSpanishString {
    switch (this) {
      case Status.alive:
        return "Vivo";
      case Status.unknown:
        return "Desconocido";
      case Status.dead:
        return "Muerto";
    }
  }
}

final statusValues = EnumValues({
  "Alive": Status.alive,
  "Dead": Status.dead,
  "unknown": Status.unknown,
});
