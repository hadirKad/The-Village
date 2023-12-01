import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_village/game/level/button.dart';
import 'package:the_village/game/level/level.dart';

import 'actors/player.dart';

class TheVillageGame extends FlameGame with HasCollisionDetection , HasKeyboardHandlerComponents{

  ///background color
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  World? _currentLevel ;
  late CameraComponent cam;
  Player player = Player();
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    _loadLevel('Level01.tmx');
    _loadImage();
    _addJoystick();
    add(Button(buttonImage: "HUD/JumpButton.png" ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
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
          world: _currentLevel, width: size.x, height: size.y);
    }
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, _currentLevel!]);

  }

  void _loadImage() async{
    await images.loadAll([
      "Main Characters/Virtual Guy/Idle (32x32).png",
      "Main Characters/Virtual Guy/Run (32x32).png",
      "Main Characters/Virtual Guy/Jump (32x32).png",
      "Main Characters/Virtual Guy/Fall (32x32).png",
      "Items/Fruits/Collected.png",
      "Items/Fruits/Pineapple.png",
      "Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png",
      "Items/Boxes/Box2/Idle.png",
      "HUD/left_button.png",
      "HUD/right_button.png",
      'HUD/Knob.png',
      'HUD/Joystick.png',
      'HUD/JumpButton.png'
    ]);
  }

  void _addJoystick() {
    joystick = JoystickComponent(
      priority:11,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      //knobRadius: 62,
      background: SpriteComponent(
          sprite: Sprite(
            images.fromCache('HUD/Joystick.png'),
          )),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    add(joystick);

  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.hAxisInput = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.hAxisInput = 1;
        break;
      default:
        player.hAxisInput = 0;
        break;
    }
  }
}