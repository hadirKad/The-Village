import 'dart:async';

import 'package:flame/components.dart';
import 'package:the_village/game/the_village_game.dart';

class Checkpoint extends SpriteAnimationComponent with HasGameRef<TheVillageGame>{

  Checkpoint({position}) : super (position: position);

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache("Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png"),
        SpriteAnimationData.sequenced(
            amount: 10, stepTime: stepTime, textureSize: Vector2.all(64)));
    return super.onLoad();
  }

}