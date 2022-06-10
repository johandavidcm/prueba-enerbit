import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:enerbit_prueba/src/blocs/characters/characters_bloc.dart';
import 'package:enerbit_prueba/src/models/basefailure/basefailure.dart';
import 'package:enerbit_prueba/src/models/characters/character.dart';
import 'package:enerbit_prueba/src/models/characters/characters_response.dart';
import 'package:enerbit_prueba/src/models/characters/info_response.dart';
import 'package:enerbit_prueba/src/models/location/location.dart';
import 'package:enerbit_prueba/src/services/characters_service.dart';
import 'package:enerbit_prueba/src/services/episodies_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_list.mocks.dart';

void main() {
  late CharactersBloc charactersBloc;
  late CharactersService charactersService;
  late EpisodieService episodieService;

  setUp(() {
    charactersService = MockCharactersService();
    episodieService = MockEpisodieService();
    SharedPreferences.setMockInitialValues({
      'favs': ['2'],
    });
    charactersBloc = CharactersBloc(
      charactersService: charactersService,
      episodieService: episodieService,
    );
  });

  group(
    "Characters Bloc Test",
    () {
      final customState = CharactersState.initialState();
      const BaseFailure defaultBaseFailure =
          BaseFailure(errorMessage: 'errorMessage');

      blocTest<CharactersBloc, CharactersState>(
        "OnNextPageRequested is called and fetchNext returns a baseFailure",
        build: () {
          when(charactersService.fetchNext(
            nextPage: customState.nextPage.getOrElse(() => null),
            searchTerm: customState.searchTerm.getOrElse(() => null),
          )).thenAnswer((_) async => left(defaultBaseFailure));
          return charactersBloc;
        },
        seed: () => customState.copyWith(
          hasReachedMax: false,
        ),
        act: (bloc) => bloc.add(const CharactersEvent.onNextPageRequested()),
        expect: () => [
          customState.copyWith(
            isRequestingCharacters: true,
          ),
          customState.copyWith(
            isRequestingCharacters: false,
          ),
        ],
      );

      final CharactersResponse charactersResponse = CharactersResponse(
        info: const Info(
          count: 10,
          pages: 10,
        ),
        results: [
          Character(
            id: 1,
            name: 'name1',
            type: 'type1',
            origin: const Location(
              name: 'name1',
              url: 'url1',
            ),
            location: const Location(
              name: 'name1',
              url: 'url',
            ),
            image: 'image1',
            episode: const [],
            url: 'url',
            created: DateTime(2020),
            isFavorite: false,
          ),
          Character(
            id: 2,
            name: 'name2',
            type: 'type2',
            origin: const Location(
              name: 'name2',
              url: 'url2',
            ),
            location: const Location(
              name: 'name2',
              url: 'url2',
            ),
            image: 'image2',
            episode: const [],
            url: 'url2',
            created: DateTime(2020),
            isFavorite: false,
          ),
        ],
      );

      final expectedListCharacters = [
        Character(
          id: 1,
          name: 'name1',
          type: 'type1',
          origin: const Location(
            name: 'name1',
            url: 'url1',
          ),
          location: const Location(
            name: 'name1',
            url: 'url',
          ),
          image: 'image1',
          episode: const [],
          url: 'url',
          created: DateTime(2020),
          isFavorite: false,
        ),
        Character(
          id: 2,
          name: 'name2',
          type: 'type2',
          origin: const Location(
            name: 'name2',
            url: 'url2',
          ),
          location: const Location(
            name: 'name2',
            url: 'url2',
          ),
          image: 'image2',
          episode: const [],
          url: 'url2',
          created: DateTime(2020),
          isFavorite: true,
        ),
      ];
      blocTest<CharactersBloc, CharactersState>(
        "OnNextPageRequested is called and fetchNext returns a CharactersResponse",
        build: () {
          when(charactersService.fetchNext(
            nextPage: customState.nextPage.getOrElse(() => null),
            searchTerm: customState.searchTerm.getOrElse(() => null),
          )).thenAnswer((_) async => right(charactersResponse));
          return charactersBloc;
        },
        seed: () => customState.copyWith(
          hasReachedMax: false,
        ),
        act: (bloc) => bloc.add(const CharactersEvent.onNextPageRequested()),
        expect: () => [
          customState.copyWith(
            isRequestingCharacters: true,
          ),
          customState.copyWith(
            isRequestingCharacters: true,
            hasReachedMax: charactersResponse.info.next == null,
            nextPage: some(charactersResponse.info.next),
            characters: [
              ...customState.characters,
              ...expectedListCharacters,
            ],
          ),
          customState.copyWith(
            hasReachedMax: charactersResponse.info.next == null,
            nextPage: some(charactersResponse.info.next),
            characters: [
              ...customState.characters,
              ...expectedListCharacters,
            ],
            isRequestingCharacters: false,
          ),
        ],
      );
    },
  );
}
