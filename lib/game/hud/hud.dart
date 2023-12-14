import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:the_village/game/the_village_game.dart';

class Hud extends Component with HasGameRef<TheVillageGame>{

 Hud({super.children , super.priority}){
    PositionType.viewport;
 }

 @override
  FutureOr<void> onLoad() {
    final scoreTextComponent = TextComponent(text: 'Score : 0' , position: Vector2.all(10));
    add(scoreTextComponent);

    final healthTextComponent = TextComponent(text: 'X5' , anchor: Anchor.topRight ,
     position: Vector2(gameRef.size.x -10 ,10 ));
    add(healthTextComponent);
    
    final playerSprite = SpriteComponent.fromImage(
      game.images.fromCache("Main Characters/Virtual Guy/Jump (32x32).png"),
      srcPosition: Vector2.zero(),
      srcSize: Vector2.all(32),
      anchor: Anchor.topRight,
      position: Vector2(
          healthTextComponent.position.x - healthTextComponent.size.x - 5, 5),
    );
    add(playerSprite);
    
    return super.onLoad();
  }

}