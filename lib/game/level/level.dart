import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World{
  final String levelName;

  Level(this.levelName):super();

  @override
  FutureOr<void> onLoad() async{
    final level = await TiledComponent.load(levelName, Vector2.all(32));
    add(level);
    return super.onLoad();
  }

}