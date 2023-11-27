import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:the_village/game/the_village_game.dart';

class Fruit extends SpriteAnimationComponent with HasGameRef<TheVillageGame> , CollisionCallbacks{

  Fruit({position}) : super (position: position);

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
      position: Vector2(10, 10),
      size: Vector2(12, 12),
    ));
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("Items/Fruits/Pineapple.png"),
        SpriteAnimationData.sequenced(
            amount: 17, stepTime: stepTime, textureSize: Vector2.all(32)));
    return super.onLoad();
  }

  Future<void> collidedWithPlayer() async {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("Items/Fruits/Collected.png"),
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: stepTime,
            textureSize: Vector2.all(32),
            loop: false));

    await animationTicker?.completed;
    removeFromParent();
  }

}