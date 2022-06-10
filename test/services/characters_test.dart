import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enerbit_prueba/src/models/basefailure/basefailure.dart';
import 'package:enerbit_prueba/src/models/characters/characters_response.dart';
import 'package:enerbit_prueba/src/repositories/characters_repository.dart';
import 'package:enerbit_prueba/src/services/characters_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_list.mocks.dart';

void main() {
  group(
    "Characters Service",
    () {
      late CharactersService charactersService;
      late CharactersRepository charactersRepository;

      setUp(() {
        charactersRepository = MockCharactersRepository();
        charactersService = CharactersService(
          charactersRepository: charactersRepository,
        );
      });

      const BaseFailure defaultBaseFailure = BaseFailure();

      test(
        "should call fetchNext and returns the same basefailure than _charactersRepository.fetchNext",
        () async {
          // Init Data
          const String searchTerm = 'searchTerm';

          // Stubbing
          when(charactersRepository.fetchNext(
            nextPage: null,
            queryParameters: argThat(
              predicate<Map<String, dynamic>?>(
                (queryParameters) =>
                    queryParameters != null &&
                    queryParameters["name"] == searchTerm &&
                    queryParameters.entries.length == 1,
              ),
              named: 'queryParameters',
            ),
          )).thenAnswer((_) async => left(defaultBaseFailure));

          // Action
          final response = await charactersService.fetchNext(
            searchTerm: searchTerm,
          );
          final foldResponse = response.fold(
            (baseFailure) => baseFailure,
            (characterResponse) => characterResponse,
          );

          // Asserts
          expect(response.isLeft(), isTrue);
          expect(foldResponse, defaultBaseFailure);

          // Verify
          verify(
            charactersRepository.fetchNext(
              nextPage: null,
              queryParameters: argThat(
                predicate<Map<String, dynamic>?>(
                  (queryParameters) =>
                      queryParameters != null &&
                      queryParameters["name"] == searchTerm &&
                      queryParameters.entries.length == 1,
                ),
                named: 'queryParameters',
              ),
            ),
          ).called(1);
        },
      );

      test(
        "should call fetchNext and should trows an exception because the it can't parse the data to model",
        () async {
          // Init Data

          // Expected responses
          final Map<String, dynamic> expectedMap = {};
          final Response<Map<String, dynamic>> expectedHttpResponse = Response(
            requestOptions: RequestOptions(
              path: '',
            ),
            data: expectedMap,
          );
          const expectedBaseFailure = BaseFailure(
            errorMessage: 'Ha ocurrido un error al convertir los datos',
          );

          // Stubbing
          when(charactersRepository.fetchNext(
            nextPage: null,
            queryParameters: null,
          )).thenAnswer((_) async => right(expectedHttpResponse));

          // Action
          final response = await charactersService.fetchNext();
          final foldResponse = response.fold(
            (baseFailure) => baseFailure,
            (characterResponse) => characterResponse,
          );

          // Asserts
          expect(response.isLeft(), isTrue);
          expect(foldResponse, expectedBaseFailure);

          // Verify
          verify(charactersRepository.fetchNext(
            nextPage: null,
            queryParameters: null,
          )).called(1);
        },
      );

      test(
        "should call fetchNext and should return a basefailure because the answer is null",
        () async {
          // Init Data

          // Expected responses
          const Map<String, dynamic>? expectedMap = null;
          final Response<Map<String, dynamic>> expectedHttpResponse = Response(
            requestOptions: RequestOptions(
              path: '',
            ),
            data: expectedMap,
          );
          const expectedBaseFailure = BaseFailure(
            errorMessage: 'No ha sido posible obtener una respuesta',
          );

          // Stubbing
          when(charactersRepository.fetchNext(
            nextPage: null,
            queryParameters: null,
          )).thenAnswer((_) async => right(expectedHttpResponse));

          // Action
          final response = await charactersService.fetchNext();
          final foldResponse = response.fold(
            (baseFailure) => baseFailure,
            (characterResponse) => characterResponse,
          );

          // Asserts
          expect(response.isLeft(), isTrue);
          expect(foldResponse, expectedBaseFailure);

          // Verify
          verify(charactersRepository.fetchNext(
            nextPage: null,
            queryParameters: null,
          )).called(1);
        },
      );

      test(
        "should call fetchNext and returns a succeced response",
        () async {
          // Init Data

          // Expected responses
          final Map<String, dynamic> expectedMap = {
            "info": {
              "count": 826,
              "pages": 42,
              "next": "https://rickandmortyapi.com/api/character/?page=2",
              "prev": null
            },
            "results": [
              {
                "id": 1,
                "name": "Rick Sanchez",
                "status": "Alive",
                "species": "Human",
                "type": "",
                "gender": "Male",
                "origin": {
                  "name": "Earth (C-137)",
                  "url": "https://rickandmortyapi.com/api/location/1"
                },
                "location": {
                  "name": "Citadel of Ricks",
                  "url": "https://rickandmortyapi.com/api/location/3"
                },
                "image":
                    "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                "episode": [
                  "https://rickandmortyapi.com/api/episode/1",
                ],
                "url": "https://rickandmortyapi.com/api/character/1",
                "created": "2017-11-04T18:48:46.250Z"
              },
            ]
          };
          final Response<Map<String, dynamic>> expectedHttpResponse = Response(
            requestOptions: RequestOptions(
              path: '',
            ),
            data: expectedMap,
          );
          final expectedResponse = CharactersResponse.fromJson(expectedMap);

          // Stubbing
          when(charactersRepository.fetchNext(
            nextPage: null,
            queryParameters: null,
          )).thenAnswer((_) async => right(expectedHttpResponse));

          // Action
          final response = await charactersService.fetchNext();
          final foldResponse = response.fold(
            (baseFailure) => baseFailure,
            (characterResponse) => characterResponse,
          );

          // Asserts
          expect(response.isRight(), isTrue);
          expect(foldResponse, expectedResponse);

          // Verify
          verify(charactersRepository.fetchNext(
            nextPage: null,
            queryParameters: null,
          )).called(1);
        },
      );
    },
  );
}
