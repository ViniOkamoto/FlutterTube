import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_tube/models/video.dart';
import 'package:flutter/material.dart';

class FavoriteBloc extends BlocBase{
  Map<String, Video> _favorites = {};

  final StreamController<Map<String, Video>> _favController = StreamController<Map<String, Video>>();

  Stream<Map<String, Video>> get outVideos => _favController.stream;

  void toggleFavorite(Video video){
    if(_favorites.containsKey(video.id))_favorites.remove(video.id)
  }
  @override
  void dispose(){
    _favController.close();
    super.dispose();
}
}