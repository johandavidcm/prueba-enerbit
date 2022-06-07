import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'repositories/characters_repository.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharactersRepository(dio: Dio()).fetchNext();
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
