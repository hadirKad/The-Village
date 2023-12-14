import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_village/game/hud/hud.dart';
import 'package:the_village/game/level/button.dart';
import 'package:the_village/game/level/level.dart';

import 'actors/player.dart';

class TheVillageGame extends FlameGame with HasCollisionDetection , HasKeyboardHandlerComponents{

  ///background color
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  World? _currentLevel ;
  late CameraComponent cam;
  late JoystickComponent joystick;
  Player player = Player();
  

  @override
  FutureOr<void> onLoad() async {
    loadLevel('Level02.tmx');
    await images.loadAll([
      "Main Characters/Virtual Guy/Idle (32x32).png",
      "Main Characters/Virtual Guy/Run (32x32).png",
      "Main Characters/Virtual Guy/Jump (32x32).png",
      "Main Characters/Virtual Guy/Fall (32x32).png",
      "Main Characters/Mask Dude/Run (32x32).png",
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

    add(Hud(priority: 1));
    
    _addControllers();
    
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }
  void loadLevel(String levelName){
    ///if we already have level w remove it from the world
    _currentLevel?.removeFromParent();
    ///we create a new level with the level name
    _currentLevel = Level(levelName: levelName , player: player);
    cam = CameraComponent(world: _currentLevel)
      ..viewport.size = Vector2(size.x, size.y)
      ..viewfinder.position = Vector2(0, 0)
      ..viewfinder.anchor = Anchor.topLeft
      ..viewport.position = Vector2(400, 0);

    addAll([cam , _currentLevel!]);

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

  void _addControllers() {
    _addJoystick();
    add(Button(buttonImage: "HUD/JumpButton.png" ));
  }
}