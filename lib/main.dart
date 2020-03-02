import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_tube/api.dart';
import 'package:bloc_tube/blocs/favorite_bloc.dart';
import 'package:bloc_tube/blocs/videos_bloc.dart';
import 'package:bloc_tube/screens/home/home.dart';
import 'package:flutter/material.dart';

void main (){
  Api api = Api();
  api.search("eletro");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i)=> VideosBloc()), Bloc((i)=> FavoriteBloc())],
      child: MaterialApp(
        title: "FlutterTube",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
