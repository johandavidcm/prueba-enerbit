import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/characters/character.dart';
import '../../models/characters/characters_response.dart';
import '../../models/episodies/episodie.dart';
import '../../services/characters_service.dart';
import '../../services/episodies_service.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersService _charactersService;
  final EpisodieService _episodieService;

  CharactersBloc({
    required CharactersService charactersService,
    required EpisodieService episodieService,
  })  : _charactersService = charactersService,
        _episodieService = episodieService,
        super(CharactersState.initialState()) {
    on<OnNextPageRequested>(_handleOnNextPageRequested);
    on<OnAddToFavoriteRequested>(_handleOnAddToFavoriteRequested);
    on<OnDeleteFavoriteRequested>(_handleOnDeleteFavoriteRequested);
    on<OnSelectedCharacterChanged>(_handleOnSelectedCharacterChanged);
    on<OnSearchWithFilterRequested>(
      _handleOnSearchWithFilterRequested,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 400))
          .asyncExpand(mapper),
    );
  }

  Future<void> _handleOnNextPageRequested(
    OnNextPageRequested event,
    Emitter<CharactersState> emit,
  ) async {
    if (!state.hasReachedMax) {
      await _getCharacters(emit);
    }
  }

  Future<void> _getCharacters(
    Emitter<CharactersState> emit,
  ) async {
    emit(
      state.copyWith(
        isRequestingCharacters: true,
      ),
    );
    final response = await _charactersService.fetchNext(
      nextPage: state.nextPage.getOrElse(() => null),
      searchTerm: state.searchTerm.getOrElse(() => null),
    );
    final foldResponse = response.fold(
      (baseFailure) => baseFailure,
      (charactersResponse) => charactersResponse,
    );
    if (response.isRight()) {
      final charactersResponse = foldResponse as CharactersResponse;
      final sharedPreferences = await SharedPreferences.getInstance();
      List<String>? favsCharacters = sharedPreferences.getStringList('favs');
      favsCharacters ??= [];
      final characters = _assingCharacterList(
        charactersResponse.results,
        favsCharacters,
      );
      emit(
        state.copyWith(
          hasReachedMax: charactersResponse.info.next == null,
          nextPage: some(charactersResponse.info.next),
          characters: [
            ...state.characters,
            ...characters,
          ],
        ),
      );
    }
    emit(
      state.copyWith(
        isRequestingCharacters: false,
      ),
    );
  }

  List<Character> _assingCharacterList(
    List<Character> listCharacters,
    List<String> listIds,
  ) {
    return listCharacters.map((character) {
      if (listIds.contains(character.id.toString())) {
        return character.copyWith(
          isFavorite: true,
        );
      }
      return character.copyWith(
        isFavorite: false,
      );
    }).toList();
  }

  Future<void> _handleOnAddToFavoriteRequested(
    OnAddToFavoriteRequested event,
    Emitter<CharactersState> emit,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String>? favsCharacters = sharedPreferences.getStringList('favs');
    favsCharacters ??= [];
    favsCharacters.add(event.character.id.toString());
    if (await sharedPreferences.setStringList('favs', favsCharacters)) {
      final characters = _assingCharacterList(
        state.characters,
        favsCharacters,
      );
      Character? selectedCharacter =
          state.selectedCharacter.getOrElse(() => null);
      if (selectedCharacter != null) {
        selectedCharacter = selectedCharacter.copyWith(isFavorite: true);
      }
      emit(
        state.copyWith(
          characters: characters,
          selectedCharacter: some(selectedCharacter),
        ),
      );
    }
  }

  Future<void> _handleOnDeleteFavoriteRequested(
    OnDeleteFavoriteRequested event,
    Emitter<CharactersState> emit,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String>? favsCharacters = sharedPreferences.getStringList('favs');
    favsCharacters ??= [];
    favsCharacters.removeWhere((id) => id == event.character.id.toString());
    sharedPreferences.setStringList('favs', favsCharacters);
    final characters = _assingCharacterList(
      state.characters,
      favsCharacters,
    );
    Character? selectedCharacter =
        state.selectedCharacter.getOrElse(() => null);
    if (selectedCharacter != null) {
      selectedCharacter = selectedCharacter.copyWith(isFavorite: false);
    }
    emit(
      state.copyWith(
        characters: characters,
        selectedCharacter: some(selectedCharacter),
      ),
    );
  }

  Future<void> _handleOnSelectedCharacterChanged(
    OnSelectedCharacterChanged event,
    Emitter<CharactersState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingDetail: true,
      ),
    );
    Character? character = event.character.getOrElse(() => null);
    if (character != null && character.episode.isNotEmpty) {
      final response = await _episodieService.getSingleEpisode(
        episodeUrl: character.episode[0],
      );
      final foldResponse = response.fold(
        (baseFailure) => baseFailure,
        (episodie) => episodie,
      );
      if (response.isRight()) {
        character = character.copyWith(
          firstEpisode: foldResponse as Episodie,
        );
      }
    }
    emit(
      state.copyWith(
        selectedCharacter: some(character),
        isLoadingDetail: false,
      ),
    );
  }

  Future<void> _handleOnSearchWithFilterRequested(
    OnSearchWithFilterRequested event,
    Emitter<CharactersState> emit,
  ) async {
    if (state.searchTerm.getOrElse(() => null) != event.searchTerm &&
        event.searchTerm != null) {
      emit(
        state.copyWith(
          searchTerm: some(event.searchTerm),
          characters: [],
          hasReachedMax: false,
          nextPage: none(),
        ),
      );
    }
    await _getCharacters(emit);
  }
}
