import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_characters_using_bloc/data/model/character_model.dart';
import 'package:rick_morty_characters_using_bloc/data/repo/get_character_data.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  static CharactersCubit get(context) => BlocProvider.of(context);

  final GetCharacterRepo _getCharacterRepo;
  List<Result> _charactersData = [];
  bool isSearched = false;

  CharactersCubit(this._getCharacterRepo) : super(CharactersLoading()) {
    _fetchCharacters();
  }

  void _fetchCharacters() async {
    try {
      final character = await _getCharacterRepo.getCharacterData();
      _charactersData = character.results;
      emit(CharactersLoaded(_charactersData));
    } catch (e) {
      emit(CharactersError('Failed to load characters.'));
    }
  }

  void searchCharacter(String query) {
    if (query.isNotEmpty) {
      final searchedCharacters = _charactersData
          .where(
            (character) =>
                character.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      isSearched = true;
      emit(SearchedCharactersLoaded(searchedCharacters));
    } else {
      clearSearch();
    }
  }

  void clearSearch() {
    isSearched = false;
    emit(CharactersLoaded(_charactersData));
  }
}
