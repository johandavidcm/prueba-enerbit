import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/basefailure/basefailure.dart';
import '../models/episodies/episodie.dart';
import '../repositories/episodies_repository.dart';

class EpisodieService {
  final EpisodiesRepository _episodiesRepository;

  const EpisodieService({
    required EpisodiesRepository episodiesRepository,
  }) : _episodiesRepository = episodiesRepository;

  Future<Either<BaseFailure, Episodie>> getSingleEpisode({
    required String episodeUrl,
  }) async {
    final response = await _episodiesRepository.getSingleEpisode(
      episodeUrl: episodeUrl,
    );
    final foldResponse = response.fold(
      (baseFailure) => baseFailure,
      (response) => response,
    );
    if (response.isRight()) {
      final httpResponse = foldResponse as Response<Map<String, dynamic>>;
      return right(
        Episodie.fromJson(httpResponse.data!),
      );
    } else {
      return left(foldResponse as BaseFailure);
    }
  }
}
