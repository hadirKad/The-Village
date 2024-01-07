import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:the_village/game/actors/player.dart';
import 'package:the_village/game/the_village_game.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<TheVillageGame>, CollisionCallbacks {
  final double _speed = 50;
  Vector2 targetPosition;

  Enemy({position, required this.targetPosition}) : super(position: position) {
    final SequenceEffect effect = SequenceEffect(
      [
        MoveToEffect(
          targetPosition,
          EffectController(speed: _speed),
          onComplete: () => flipHorizontallyAroundCenter(),
        ),
        MoveToEffect(
          position,
          EffectController(speed: _speed),
          onComplete: () => flipHorizontallyAroundCenter(),
        ),
      ],
      infinite: true,
    );

    add(effect);
  }

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("Main Characters/Mask Dude/Run (32x32).png"),
        SpriteAnimationData.sequenced(
            amount: 11, stepTime: stepTime, textureSize: Vector2(32, 32)));

    add(CircleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      final playerDir = (other.absoluteCenter - absoluteCenter).normalized();
      if (playerDir.dot(Vector2(0, -1)) > 0.85) {
        add(OpacityEffect.fadeOut(
            EffectController(alternate: true, duration: 0.2, repeatCount: 1 , ),
            onComplete: ()=> removeFromParent()));
        
        other.jump();
      } else {
        other.hit();
        if (gameRef.playerData.health.value > 0) {
          gameRef.playerData.health.value -= 1;
        }
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
