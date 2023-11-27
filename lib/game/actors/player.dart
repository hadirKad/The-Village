import 'dart:async';

import 'package:flame/components.dart';
import 'package:the_village/game/the_village_game.dart';


///put all the player state in enum so is will be easy to call them
enum PlayerState {
  idle,
}


///group animation means that the player have to many animation and you need to switch between them///
///has game ref is to reference the player with the game so we can use the component inside it ///
class Player extends SpriteAnimationGroupComponent with HasGameRef<TheVillageGame>{
  ///get position and set the original position which is (0,0)
  Player({position}) : super(position: position);

  ///animation var
  late final SpriteAnimation idleAnimation;
  ///stepTime = how fast the images changes
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  ///function to create all animation
  void _loadAllAnimation() {
    ///create animation based on image
    ///the image are saved in cache in the game Pixel adventure that we add it in HasGameRef<PixelAdventure>
    ///amount = number of item in animation image
    ///stepTime = how fast the images changes
    idleAnimation = _spriteAnimation(11, "Idle");
    ///list of all animations
    animations = {
      PlayerState.idle: idleAnimation,
    };
    ///set the current animation
    current = PlayerState.idle;
  }

  ///function to create sprite animation
  SpriteAnimation _spriteAnimation(int amount, String state) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache("Main Characters/Virtual Guy/$state (32x32).png"),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: stepTime, textureSize: Vector2.all(32)));
  }

}