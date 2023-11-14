// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class AbcVideoPage extends StatefulWidget {
//   @override
//   _AbcVideoPageState createState() => _AbcVideoPageState();
// }

// class _AbcVideoPageState extends State<AbcVideoPage> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
    
//     _controller = YoutubePlayerController(
//       initialVideoId: 'https://youtu.be/T4FKufhMc44?si=T-V44_rwf8xEYlBn',
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ABC Video'),
//       ),
//       body: Center(
//         child: YoutubePlayer(
//           controller: _controller,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.blueAccent,
//           topActions: <Widget>[
//             const SizedBox(width: 8.0),
//             Expanded(
//               child: Text(
//                 _controller.metadata.title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 15.0,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//           ],
//           onReady() {
//             // Do something when the video is ready.
//           },
//           onEnded() {
//             // Do something when the video ends.
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
