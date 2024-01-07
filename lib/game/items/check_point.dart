import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:the_village/game/actors/player.dart';
import 'package:the_village/game/the_village_game.dart';

class Checkpoint extends SpriteAnimationComponent with HasGameRef<TheVillageGame> , CollisionCallbacks{

  String nextLevel;
  Checkpoint({position , required this.nextLevel}) : super (position: position);

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
        position: Vector2(20, 20),
        size: Vector2(5, 42),
      collisionType: CollisionType.passive
    ));
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png"),
        SpriteAnimationData.sequenced(
            amount: 10, stepTime: stepTime, textureSize: Vector2.all(64)));
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player){
      gameRef.loadLevel(nextLevel);
    }
    super.onCollisionStart(intersectionPoints, other);
  }


}