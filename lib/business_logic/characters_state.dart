part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Result> characters;
  CharactersLoaded(this.characters);
}

class SearchedCharactersLoaded extends CharactersState {
  final List<Result> searchedCharacters;
  SearchedCharactersLoaded(this.searchedCharacters);
}

class CharactersError extends CharactersState {
  final String message;
  CharactersError(this.message);
}
