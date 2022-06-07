import 'character.dart';
import 'info_response.dart';

class CharactersResponse {
  CharactersResponse({
    required this.info,
    required this.results,
  });

  final Info info;
  final List<Character> results;

  factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
      CharactersResponse(
        info: Info.fromJson(json["info"]),
        results: List<Character>.from(
          json["results"].map(
            (x) => Character.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
