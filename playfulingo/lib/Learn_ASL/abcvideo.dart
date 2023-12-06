import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AbcVideoPage extends StatefulWidget {
  @override
  _AbcVideoPageState createState() => _AbcVideoPageState();
}

class _AbcVideoPageState extends State<AbcVideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'T4FKufhMc44',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
       backgroundColor: Colors.purple[300],
         iconTheme: IconThemeData(
      color: Colors.white, // Change the color of the back arrow here
    ),
        title: const Text(
          'ABC Video', 
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
            ),),),
      
      body: Center(
         
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              
            },
            onEnded: (YoutubeMetaData metaData) {
             
            },
          ),
          builder: (context, player) {
            return Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                player,
                SizedBox(height: 16.0),
                Text(
                  _controller.metadata.title ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
