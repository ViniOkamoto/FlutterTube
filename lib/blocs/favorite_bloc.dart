import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_tube/models/video.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends BlocBase{
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>(seedValue: {});

  Stream<Map<String, Video>> get outVideos => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
     if(prefs.getKeys().contains("favorites")){
       _favorites = json.decode(prefs.getString("favorites")).map((key, value){
         return MapEntry(key, Video.fromJason(value));
       }).cast<String, Video>();

       //cast is been used to convert the dynamic to String.
       _favController.add(_favorites);
     }
    });
  }

  void toggleFavorite(Video video){
    if(_favorites.containsKey(video.id))_favorites.remove(video.id);
    else _favorites[video.id] = video;

    _favController.sink.add(_favorites);

    _saveFav();
  }
  //here to translate the object to json
  void _saveFav() {
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(_favorites));
    });
  }
  @override
  void dispose(){
    _favController.close();
    super.dispose();
}
}

