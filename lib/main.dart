import 'package:flutter/material.dart';
import 'package:rick_morty_characters_using_bloc/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
