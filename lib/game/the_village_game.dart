import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:the_village/game/level/level.dart';

class TheVillageGame extends FlameGame {

  World? _currentLevel ;
  late CameraComponent cam;

  @override
  FutureOr<void> onLoad() async {
    loadLevel('Level01.tmx');
    return super.onLoad();
  }

  void loadLevel(String levelName){
    ///if we already have level w remove it from the world
    _currentLevel?.removeFromParent();
    ///we create a new level with the level name
    _currentLevel = Level(levelName);
    ///because the level 01 have small width w need to change the camera width
    if(levelName == "Level01.tmx"){
      cam = CameraComponent.withFixedResolution(
          world: _currentLevel, width: 680, height: 384);
    }else{
      cam = CameraComponent.withFixedResolution(
          world: _currentLevel, width: size.length, height: 384);
    }
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, _currentLevel!]);

  }

}