import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_characters_using_bloc/business_logic/characters_cubit.dart';
import 'package:rick_morty_characters_using_bloc/data/model/character_model.dart';
import 'package:rick_morty_characters_using_bloc/data/repo/get_character_data.dart';
import 'package:rick_morty_characters_using_bloc/presentation/screens/character_details_screen.dart';
import 'package:rick_morty_characters_using_bloc/presentation/screens/characters_screen.dart';


class AppRouter {
  late CharactersCubit charactersCubit;
  late GetCharacterRepo characterRepo;
  AppRouter() {
    characterRepo = GetCharacterRepo();
    charactersCubit = CharactersCubit(characterRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case '/character_details':
        final character = settings.arguments as Result;
        return MaterialPageRoute(
          builder: (context) =>
              CharactersDetailsScreen(characterDate: character),
        );
      default:
        return null;
    }
  }
}
