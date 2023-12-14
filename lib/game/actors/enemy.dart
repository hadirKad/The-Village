import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:the_village/game/the_village_game.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<TheVillageGame>{
  final double _speed = 50;
  Vector2 targetPosition ;

  Enemy({position , required this.targetPosition}) : super (position: position){
   

    // Goomba will move 100 pixels to the left and right.
    //targetPosition.x -= 100;

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
            amount: 11, stepTime: stepTime, textureSize: Vector2(32 , 32)));
    
    add(CircleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  

}