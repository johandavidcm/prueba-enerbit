import 'package:equatable/equatable.dart';

import 'character.dart';
import 'info_response.dart';

class CharactersResponse extends Equatable {
  const CharactersResponse({
    required this.info,
    required this.results,
  });

  final Info info;
  final List<Character> results;

  @override
  List<Object?> get props => [
        info,
        results,
      ];

  factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
      CharactersResponse(
        info: Info.fromJson(json["info"]),
        results: List<Character>.from(
          json["results"].map(
            (x) => Character.fromJson(x),
          ),
        ),
      );
}
