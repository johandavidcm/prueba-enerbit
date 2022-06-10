import 'package:equatable/equatable.dart';

import '../../enums/enums.dart';
import '../episodies/episodie.dart';
import '../location/location.dart';

class Character extends Equatable {
  const Character({
    required this.id,
    required this.name,
    this.status,
    this.species,
    required this.type,
    this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
    this.isFavorite = false,
    this.firstEpisode,
  });

  final int id;
  final String name;
  final Status? status;
  final Species? species;
  final String type;
  final Gender? gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;
  final bool isFavorite;
  final Episodie? firstEpisode;

  Character copyWith({
    int? id,
    String? name,
    Status? status,
    Species? species,
    String? type,
    Gender? gender,
    Location? origin,
    Location? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
    bool? isFavorite,
    Episodie? firstEpisode,
  }) =>
      Character(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        species: species ?? this.species,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        origin: origin ?? this.origin,
        location: location ?? this.location,
        image: image ?? this.image,
        episode: episode ?? this.episode,
        url: url ?? this.url,
        created: created ?? this.created,
        isFavorite: isFavorite ?? this.isFavorite,
        firstEpisode: firstEpisode ?? this.firstEpisode,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
        created,
        isFavorite,
        firstEpisode,
      ];

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]],
        species: speciesValues.map[json["species"]],
        type: json["type"],
        gender: genderValues.map[json["gender"]],
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );
}
