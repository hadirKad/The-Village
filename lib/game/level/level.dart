import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:the_village/game/items/box.dart';
import 'package:the_village/game/items/Fruit.dart';
import 'package:the_village/game/items/check_point.dart';
import 'package:the_village/game/items/platfom.dart';

import '../actors/player.dart';

class Level extends World{
  final String levelName;
  final Player player;
  /// the level is a tiledComponent
  late TiledComponent level;

  Level({required this.levelName, required this.player}):super();

  @override
  FutureOr<void> onLoad() async{
    level = await TiledComponent.load(levelName, Vector2.all(16));
    add(level);
    _spawningObjects();
    _spawningPlatform();
    return super.onLoad();
  }
  void _spawningObjects() {
    /// get the spawn points layer with type object group and name SpawnPoints
    ///if spawnPointLayer in null the game will stop so we need to check i
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    if (spawnPointsLayer != null) {
      ///loop in the layer object and when we found player w add it there
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
          ///we put the character in the same spawn point x and y
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          case 'Fruit':
            Fruit fruit = Fruit();
          ///we put the fruit in the same spawn point x and y
            fruit.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(fruit);
            break;
          case 'Checkpoint':
            Checkpoint checkpoint = Checkpoint();
            ///we put the fruit in the same spawn point x and y
            checkpoint.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(checkpoint);
            break;
          case 'Box':
            Box box = Box();
            ///we put the fruit in the same spawn point x and y
            box.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(box);
            break;
        }
      }
    }
  }
  void _spawningPlatform() {
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Platforms');
    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
          final platform = Platform(
              position: Vector2(spawnPoint.x , spawnPoint.y),
              size: Vector2(spawnPoint.width , spawnPoint.height));
          add(platform);
        }
      }
    }

}