import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/animation.dart';
import 'package:the_village/game/level/level.dart';

import 'actors/player.dart';

class TheVillageGame extends FlameGame {

  ///background color
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  World? _currentLevel ;
  late CameraComponent cam;
  Player player = Player();

  @override
  FutureOr<void> onLoad() async {
    _loadLevel('Level02.tmx');
    _loadImage();
    return super.onLoad();
  }

  void _loadLevel(String levelName){
    ///if we already have level w remove it from the world
    _currentLevel?.removeFromParent();
    ///we create a new level with the level name
    _currentLevel = Level(levelName: levelName, player: player);
    ///because the level 01 have small width w need to change the camera width
    if(levelName == "Level01.tmx" ){
      cam = CameraComponent.withFixedResolution(
          world: _currentLevel, width: 680, height: 384);
    }else{
      cam = CameraComponent.withFixedResolution(
          world: _currentLevel, width: size.length, height: 384);
    }
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, _currentLevel!]);

  }

  void _loadImage() async{
    await images.loadAll([
      "Main Characters/Virtual Guy/Idle (32x32).png",
      "Items/Fruits/Pineapple.png",
      "Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png",
      "Items/Boxes/Box2/Idle.png"
    ]);
  }

}