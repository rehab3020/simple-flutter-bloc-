import 'package:flutter/material.dart';
import 'package:rick_morty_characters_using_bloc/constants/app_colors.dart';
import 'package:rick_morty_characters_using_bloc/data/model/character_model.dart';


class CharactersDetailsScreen extends StatelessWidget {
  final Result characterDate;
  const CharactersDetailsScreen({super.key, required this.characterDate});

  Widget sliverAppBar(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      expandedHeight: screenHeight * 0.7,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.grayColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ]),
          child: Text(
            characterDate.name,
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
        ),
        background: Hero(
          tag: characterDate.id,
          child: Image.network(
            characterDate.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayColor,
      body: CustomScrollView(
        slivers: [
          sliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 4, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(name: 'Name: ', value: characterDate.name),
                      const SizedBox(
                        height: 10,
                      ),
                      characterInfo(
                          name: 'Status: ', value: characterDate.status.name),
                      const SizedBox(
                        height: 10,
                      ),
                      characterInfo(
                          name: 'Species: ', value: characterDate.species.name),
                      const SizedBox(
                        height: 10,
                      ),
                      characterInfo(
                          name: 'Gender: ', value: characterDate.gender.name),
                      const SizedBox(
                        height: 10,
                      ),
                      characterInfo(
                          name: 'Origin: ', value: characterDate.origin.name),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  RichText characterInfo({required String name, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
