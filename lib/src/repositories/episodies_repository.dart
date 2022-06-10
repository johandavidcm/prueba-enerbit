import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/basefailure/basefailure.dart';

class EpisodiesRepository {
  final Dio _dio;

  const EpisodiesRepository({
    required Dio dio,
  }) : _dio = dio;

  Future<Either<BaseFailure, Response<Map<String, dynamic>>>> getSingleEpisode({
    required String episodeUrl,
  }) async {
    try {
      final httpResponse = await _dio.get<Map<String, dynamic>>(
        episodeUrl,
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
