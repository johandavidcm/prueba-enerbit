import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/basefailure/basefailure.dart';
import '../models/characters/characters_response.dart';
import '../repositories/characters_repository.dart';

class CharactersService {
  final CharactersRepository _charactersRepository;

  const CharactersService({
    required CharactersRepository charactersRepository,
  }) : _charactersRepository = charactersRepository;

  Future<Either<BaseFailure, CharactersResponse>> fetchNext({
    String? nextPage,
    String? searchTerm,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (searchTerm != null && searchTerm.isNotEmpty) {
        queryParameters["name"] = searchTerm;
      }
      final response = await _charactersRepository.fetchNext(
        queryParameters: queryParameters.isEmpty ? null : queryParameters,
        nextPage: nextPage,
      );
      final foldResponse = response.fold(
        (baseFailure) => baseFailure,
        (httpResponse) => httpResponse,
      );
      if (response.isRight()) {
        final httpResponse = foldResponse as Response<Map<String, dynamic>>;
        if (httpResponse.data != null) {
          return right(CharactersResponse.fromJson(httpResponse.data!));
        }
      }
      return left(foldResponse as BaseFailure);
    } catch (e) {
      return left(
        const BaseFailure(
          errorMessage: 'Ha ocurrido un error al convertir los datos',
        ),
      );
    }
  }
}
