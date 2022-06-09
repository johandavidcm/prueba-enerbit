import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../models/characters/character.dart';
import '../../models/characters/characters_response.dart';
import '../../services/characters_service.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersService _charactersService;

  CharactersBloc({
    required CharactersService charactersService,
  })  : _charactersService = charactersService,
        super(CharactersState.initialState()) {
    on<OnNextPageRequested>(_handleOnNextPageRequested);
  }

  Future<void> _handleOnNextPageRequested(
    OnNextPageRequested event,
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
    if (!state.hasReachedMax) {
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
        emit(
          state.copyWith(
            hasReachedMax: charactersResponse.info.next == null,
            nextPage: some(charactersResponse.info.next),
            characters: [
              ...state.characters,
              ...charactersResponse.results,
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
  }
}
