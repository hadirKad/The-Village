import 'dart:async';

import 'package:flame/components.dart';
import 'package:the_village/game/the_village_game.dart';

class Box extends SpriteAnimationComponent with HasGameRef<TheVillageGame>{

  Box({position}) : super (position: position);

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("Items/Boxes/Box2/Idle.png"),
        SpriteAnimationData.sequenced(
            amount: 1, stepTime: stepTime, textureSize: Vector2(28 , 24)));
    return super.onLoad();
  }

}