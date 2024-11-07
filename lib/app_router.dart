import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blocin_arabic/business_logic/characters_cubit.dart';
import 'package:flutter_blocin_arabic/data/repo/get_character_data.dart';
import 'package:flutter_blocin_arabic/presentation/screens/character_details_screen.dart';
import 'package:flutter_blocin_arabic/presentation/screens/characters_screen.dart';

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
            child:  CharactersScreen(),
          ),
        );
      case '/character_details':
        return MaterialPageRoute(
          builder: (context) => const CharactersDetailsScreen(),
        );
      default:
        return null;
    }
  }
}
