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
  getIt.registerSingleton<CharactersBloc>(
    CharactersBloc(
      charactersService: charactersService,
    ),
  );
}
