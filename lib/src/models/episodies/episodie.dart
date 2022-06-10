import 'package:equatable/equatable.dart';

class Episodie extends Equatable {
  const Episodie({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime created;

  @override
  List<Object?> get props => [
        id,
        name,
        airDate,
        episode,
        characters,
        url,
        created,
      ];
  Episodie copyWith({
    int? id,
    String? name,
    String? airDate,
    String? episode,
    List<String>? characters,
    String? url,
    DateTime? created,
  }) =>
      Episodie(
        id: id ?? this.id,
        name: name ?? this.name,
        airDate: airDate ?? this.airDate,
        episode: episode ?? this.episode,
        characters: characters ?? this.characters,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory Episodie.fromJson(Map<String, dynamic> json) => Episodie(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: List<String>.from(json["characters"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );
}
