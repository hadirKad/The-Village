import 'dart:async';

import 'package:flame/components.dart';
import 'package:the_village/game/actors/player.dart';
import 'package:the_village/game/hud/hud.dart';
import 'package:the_village/game/level/level.dart';

class GamePlay extends Component {

  World? _currentLevel ;
   late CameraComponent cam;

  @override
  FutureOr<void> onLoad() {
    loadLevel('Level02.tmx');
    add(Hud(priority: 1));
    return super.onLoad();
  }

  void loadLevel(String levelName){
    ///if we already have level w remove it from the world
    _currentLevel?.removeFromParent();
    ///we create a new level with the level name
    _currentLevel = Level(levelName: levelName , player: Player());
    cam = CameraComponent(world: _currentLevel)
      ..viewport.size = Vector2(600, 300)
      ..viewfinder.position = Vector2(0, 0)
      ..viewfinder.anchor = Anchor.topLeft
      ..viewport.position = Vector2(100, 0);

    addAll([cam , _currentLevel!]);

  }

  
}
