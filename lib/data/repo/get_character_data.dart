import 'package:dio/dio.dart';
import 'package:rick_morty_characters_using_bloc/constants/strings.dart';
import 'package:rick_morty_characters_using_bloc/data/model/character_model.dart';


class GetCharacterRepo {
  late final Dio dio;
  GetCharacterRepo() {
    // dio.options.baseUrl = baseUrl;
    // dio.options.receiveDataWhenStatusError = true;
    // dio.options.connectTimeout = const Duration(seconds: 20);
    // dio.options.receiveTimeout = const Duration(seconds: 20);

    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(baseOptions);
  }
  Future<CharactersModel> getCharacterData() async {
    try {
      Response response = await dio.get('character');
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return CharactersModel.fromJson({});
    }
  }
}
