import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_tube/blocs/videos_bloc.dart';
import 'package:bloc_tube/delegates/data_search.dart';
import 'package:bloc_tube/screens/home/widgets/videotile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final  bloc = BlocProvider.getBloc<VideosBloc>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
            IconButton(
              padding: EdgeInsets.all(10),
              icon: Icon(Icons.star,
                color: Colors.white,
              ),
            ),

            IconButton(
              padding: EdgeInsets.all(10),
              icon: Icon(Icons.search,
                color: Colors.white,
              ),
              onPressed: () async {
                String result = await showSearch(context: context, delegate: DataSearch());
                if(result != null) bloc.inSearch.add(result);
              },
            ),
        ],
        backgroundColor: Colors.black87,
      ),
      body: buildStreamBuilder(bloc),
    );
  }

  StreamBuilder buildStreamBuilder(bloc) {

    return StreamBuilder(
      initialData: [],
      stream: bloc.outVideos ,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                } else if(index > 1){
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                  );
                } else {
                  return Container();
                }
              },
            itemCount: snapshot.data.length + 1,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
