import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';


///position component it for component that added using tiled
///so we don't need image info only position
class Platform extends PositionComponent with CollisionCallbacks{

  Platform({required position, required size ,}): super (position: position, size: size);


  @override
  FutureOr<void> onLoad() {
    ///we use hit box to detect collisions
    ///the size of platform is the same as the rectangle hit box
    add(RectangleHitbox(collisionType: CollisionType.passive ));
    return super.onLoad();
  }

}