part of 'characters_bloc.dart';

@immutable
class CharactersState extends Equatable {
  final List<Character> characters;
  final Option<String?> nextPage;
  final Option<String?> searchTerm;
  final bool isRequestingCharacters;
  final bool hasReachedMax;

  const CharactersState({
    required this.nextPage,
    required this.searchTerm,
    this.characters = const [],
    this.isRequestingCharacters = false,
    this.hasReachedMax = false,
  });

  factory CharactersState.initialState() => CharactersState(
        nextPage: none(),
        searchTerm: none(),
      );

  @override
  List<Object?> get props => [
        characters,
        isRequestingCharacters,
        hasReachedMax,
        nextPage,
        searchTerm,
      ];

  CharactersState copyWith({
    List<Character>? characters,
    Option<String?>? nextPage,
    Option<String?>? searchTerm,
    bool? isRequestingCharacters,
    bool? hasReachedMax,
  }) =>
      CharactersState(
        characters: characters ?? this.characters,
        nextPage: nextPage ?? this.nextPage,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        searchTerm: searchTerm ?? this.searchTerm,
        isRequestingCharacters:
            isRequestingCharacters ?? this.isRequestingCharacters,
      );

  @override
  String toString() {
    return """CharactersState{
      characters: $characters,
      hasReachedMax: $hasReachedMax,
      isRequestingCharacters: $isRequestingCharacters,
      nextPage: ${nextPage.getOrElse(() => null)}
      searchTerm: ${searchTerm.getOrElse(() => null)}
    }""";
  }
}
