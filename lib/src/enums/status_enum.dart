part of 'enums.dart';

enum Status { alive, unknown, dead }

final statusValues = EnumValues({
  "Alive": Status.alive,
  "Dead": Status.dead,
  "unknown": Status.unknown,
});
