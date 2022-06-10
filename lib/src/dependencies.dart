import 'repositories/episodies_repository.dart';
import 'services/episodies_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'blocs/characters/characters_bloc.dart';
import 'repositories/characters_repository.dart';
import 'services/characters_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  final dio = Dio();
  final charactersRepository = CharactersRepository(dio: dio);
  final charactersService = CharactersService(
    charactersRepository: charactersRepository,
  );
  final episodiesRepository = EpisodiesRepository(dio: dio);
  final episodieService = EpisodieService(
    episodiesRepository: episodiesRepository,
  );

  getIt.registerSingleton<CharactersBloc>(
    CharactersBloc(
      charactersService: charactersService,
      episodieService: episodieService,
    ),
  );
}
