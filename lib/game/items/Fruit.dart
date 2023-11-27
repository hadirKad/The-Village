import 'dart:async';

import 'package:flame/components.dart';
import 'package:the_village/game/the_village_game.dart';

class Fruit extends SpriteAnimationComponent with HasGameRef<TheVillageGame>{

  Fruit({position}) : super (position: position);

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("Items/Fruits/Pineapple.png"),
        SpriteAnimationData.sequenced(
            amount: 17, stepTime: stepTime, textureSize: Vector2.all(32)));
    return super.onLoad();
  }

}