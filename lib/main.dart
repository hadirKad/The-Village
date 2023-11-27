import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_village/game/the_village_game.dart';

void main() async {
  ///waiting for flutter to initialized
  WidgetsFlutterBinding.ensureInitialized();
  ///make the game full screen
  await Flame.device.fullScreen();
  ///make the phone horizontal
  await Flame.device.setLandscape();
  runApp(const MyApp());
}

//we use this instance in the real mood 
final  _game = TheVillageGame();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "The Village",
      home: Scaffold(
        body: GameWidget(game: kDebugMode ? TheVillageGame() : _game),
      ),
    );
  }
}
