import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:the_village/game/the_village_game.dart';

class Button extends SpriteComponent with HasGameRef<TheVillageGame> , TapCallbacks{
  String buttonImage;

  Button({required this.buttonImage});

  final margin = 32;
  final buttonSize = 64;
  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(buttonImage));
    //we put the button in the bottom right
    position = Vector2(
        game.size.x - margin - buttonSize,
        game.size.y - margin - buttonSize);
    priority = 10;

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.player.jumpInput = true;
    super.onTapUp(event);
  }
  @override
  void onTapDown(TapDownEvent event) {
    gameRef.player.jumpInput = false;
    super.onTapDown(event);
  }

}