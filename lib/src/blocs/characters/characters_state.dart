part of 'characters_bloc.dart';

@immutable
class CharactersState extends Equatable {
  final List<Character> characters;
  final Option<String?> nextPage;
  final Option<String?> searchTerm;
  final Option<Character?> selectedCharacter;
  final bool isRequestingCharacters;
  final bool isLoadingDetail;
  final bool hasReachedMax;

  const CharactersState({
    required this.nextPage,
    required this.searchTerm,
    required this.selectedCharacter,
    this.characters = const [],
    this.isRequestingCharacters = false,
    this.hasReachedMax = false,
    this.isLoadingDetail = false,
  });

  factory CharactersState.initialState() => CharactersState(
        nextPage: none(),
        searchTerm: none(),
        selectedCharacter: none(),
      );

  @override
  List<Object?> get props => [
        characters,
        isRequestingCharacters,
        hasReachedMax,
        nextPage,
        searchTerm,
        selectedCharacter,
        isLoadingDetail,
      ];

  CharactersState copyWith({
    List<Character>? characters,
    Option<String?>? nextPage,
    Option<String?>? searchTerm,
    Option<Character?>? selectedCharacter,
    bool? isRequestingCharacters,
    bool? hasReachedMax,
    bool? isLoadingDetail,
  }) =>
      CharactersState(
        characters: characters ?? this.characters,
        nextPage: nextPage ?? this.nextPage,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        searchTerm: searchTerm ?? this.searchTerm,
        selectedCharacter: selectedCharacter ?? this.selectedCharacter,
        isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
        isRequestingCharacters:
            isRequestingCharacters ?? this.isRequestingCharacters,
      );

  @override
  String toString() {
    return """CharactersState{
      characters: $characters,
      hasReachedMax: $hasReachedMax,
      isRequestingCharacters: $isRequestingCharacters,
      isLoadingDetail: $isLoadingDetail,
      nextPage: ${nextPage.getOrElse(() => null)}
      selectedCharacter: ${selectedCharacter.getOrElse(() => null)}
      searchTerm: ${searchTerm.getOrElse(() => null)}
    }""";
  }
}
