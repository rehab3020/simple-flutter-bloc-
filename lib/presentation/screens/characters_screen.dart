import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_characters_using_bloc/business_logic/characters_cubit.dart';
import 'package:rick_morty_characters_using_bloc/constants/app_colors.dart';
import 'package:rick_morty_characters_using_bloc/data/model/character_model.dart';
import 'package:rick_morty_characters_using_bloc/presentation/widgets/character_item.dart';


class CharactersScreen extends StatelessWidget {
  CharactersScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharactersCubit, CharactersState>(
      listener: (context, state) {
        if (state is CharactersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final cubit = CharactersCubit.get(context);
        return Scaffold(
          appBar: _buildAppBar(context, cubit),
          body: _buildBody(context, state),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, CharactersCubit cubit) {
    return AppBar(
      backgroundColor: AppColors.yellowColor,
      title: cubit.isSearched
          ? _buildSearchField(context)
          : const Text(
              'Rick and Morty Characters',
              style: TextStyle(color: AppColors.grayColor),
            ),
      actions: _buildAppBarActions(context, cubit),
    );
  }

  Widget _buildBody(BuildContext context, CharactersState state) {
    if (state is CharactersLoading) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.yellowColor));
    } else if (state is CharactersLoaded) {
      return _buildCharacterList(state.characters);
    } else if (state is SearchedCharactersLoaded) {
      return _buildCharacterList(state.searchedCharacters);
    } else {
      return const Center(child: Text('Failed to load characters.'));
    }
  }

  Widget _buildCharacterList(List<Result> characters) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.grayColor,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: characters.length,
          itemBuilder: (context, index) {
            return CharacterItem(characterItem: characters[index]);
          },
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      controller: _searchController,
      cursorColor: AppColors.grayColor,
      decoration: const InputDecoration(
        hintText: 'Search',
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppColors.grayColor, fontSize: 18),
      ),
      style: const TextStyle(color: AppColors.grayColor, fontSize: 18),
      onChanged: CharactersCubit.get(context).searchCharacter,
    );
  }

  List<Widget> _buildAppBarActions(
      BuildContext context, CharactersCubit cubit) {
    return [
      if (cubit.isSearched)
        IconButton(
          onPressed: () {
            _searchController.clear();
            cubit.clearSearch();
          },
          icon: const Icon(Icons.clear, color: AppColors.grayColor),
        )
      else
        IconButton(
          onPressed: () {
            ModalRoute.of(context)!.addLocalHistoryEntry(
              LocalHistoryEntry(onRemove: cubit.clearSearch),
            );
            cubit.isSearched = true;
          },
          icon: const Icon(Icons.search, color: AppColors.grayColor),
        ),
    ];
  }
}
