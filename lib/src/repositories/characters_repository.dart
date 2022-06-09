import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/env_config.dart';
import '../models/basefailure/basefailure.dart';

class CharactersRepository {
  final Dio _dio;

  const CharactersRepository({
    required Dio dio,
  }) : _dio = dio;

  Future<Either<BaseFailure, Response<Map<String, dynamic>>>> fetchNext({
    Map<String, dynamic>? queryParameters,
    String? nextPage,
  }) async {
    try {
      final String url = nextPage != null && nextPage.isNotEmpty
          ? nextPage
          : "${EnvConfig.instance!.values.baseUrl}${EnvConfig.instance!.values.charactersPath}";
      final httpResponse = await _dio.get<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
      );
      return right(httpResponse);
    } catch (e) {
      debugPrint(e.toString());
      return left(
        const BaseFailure(),
      );
    }
  }
}
