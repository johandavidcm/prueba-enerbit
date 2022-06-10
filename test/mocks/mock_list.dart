import 'package:enerbit_prueba/src/repositories/characters_repository.dart';
import 'package:enerbit_prueba/src/services/characters_service.dart';
import 'package:enerbit_prueba/src/services/episodies_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  CharactersService,
  EpisodieService,
  CharactersRepository,
])
void generateMocks() {}
