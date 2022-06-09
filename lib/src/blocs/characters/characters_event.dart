part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent {
  const CharactersEvent();

  const factory CharactersEvent.onNextPageRequested({
    String? searchTerm,
  }) = OnNextPageRequested;
}

class OnNextPageRequested extends CharactersEvent {
  final String? searchTerm;
  const OnNextPageRequested({
    this.searchTerm,
  });

  @override
  String toString() {
    return "CharactersEvent.OnNextPageRequested($searchTerm)";
  }
}
