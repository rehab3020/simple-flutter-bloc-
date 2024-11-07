import 'package:flutter/material.dart';
import 'package:flutter_blocin_arabic/constants/app_colors.dart';
import 'package:flutter_blocin_arabic/data/model/character_model.dart';

class CharacterItem extends StatelessWidget {
  final Result characterItem;
  const CharacterItem({super.key, required this.characterItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          color: Colors.black54,
          alignment: Alignment.bottomCenter,
          child: Text(
            characterItem.name,
            style: const TextStyle(
              height: 1.3,
              fontSize: 16,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        child: Container(
          color: AppColors.grayColor,
          child: characterItem.image.isNotEmpty
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: characterItem.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/images/1.jpeg'),
        ),
      ),
    );
  }
}
