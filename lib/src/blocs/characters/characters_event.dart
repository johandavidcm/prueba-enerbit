part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent {
  const CharactersEvent();

  const factory CharactersEvent.onNextPageRequested() = OnNextPageRequested;

  const factory CharactersEvent.onAddToFavoriteRequested({
    required Character character,
  }) = OnAddToFavoriteRequested;

  const factory CharactersEvent.onDeleteFavoriteRequested({
    required Character character,
  }) = OnDeleteFavoriteRequested;

  const factory CharactersEvent.onSelectedCharacterChanged({
    required Option<Character?> character,
  }) = OnSelectedCharacterChanged;

  const factory CharactersEvent.onSearchWithFilterRequested({
    String? searchTerm,
  }) = OnSearchWithFilterRequested;
}

class OnNextPageRequested extends CharactersEvent {
  const OnNextPageRequested();

  @override
  String toString() {
    return "CharactersEvent.OnNextPageRequested()";
  }
}

class OnSearchWithFilterRequested extends CharactersEvent {
  final String? searchTerm;

  const OnSearchWithFilterRequested({
    this.searchTerm,
  });

  @override
  String toString() {
    return "CharactersEvent.OnSearchWithFilterRequested($searchTerm)";
  }
}

class OnAddToFavoriteRequested extends CharactersEvent {
  final Character character;

  const OnAddToFavoriteRequested({
    required this.character,
  });

  @override
  String toString() {
    return "CharactersEvent.OnAddToFavoriteRequested($character)";
  }
}

class OnDeleteFavoriteRequested extends CharactersEvent {
  final Character character;

  const OnDeleteFavoriteRequested({
    required this.character,
  });

  @override
  String toString() {
    return "CharactersEvent.OnDeleteFavoriteRequested($character)";
  }
}

class OnSelectedCharacterChanged extends CharactersEvent {
  final Option<Character?> character;

  const OnSelectedCharacterChanged({
    required this.character,
  });

  @override
  String toString() {
    return "CharactersEvent.OnDeleteFavoriteRequested($character)";
  }
}
