import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:the_village/game/items/Fruit.dart';
import 'package:the_village/game/items/platfom.dart';
import 'package:the_village/game/the_village_game.dart';


///put all the player state in enum so is will be easy to call them
enum PlayerState {
  idle,
  running,
  jumping,
  falling,
}


///group animation means that the player have to many animation and you need to switch between them///
///has game ref is to reference the player with the game so we can use the component inside it ///
class Player extends SpriteAnimationGroupComponent with
    HasGameRef<TheVillageGame> , CollisionCallbacks , KeyboardHandler{
  ///get position and set the original position which is (0,0)
  Player({position}) : super(position: position);

  ///animation var
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;
  ///stepTime = how fast the images changes
  final double stepTime = 0.05;
  final Vector2 _velocity = Vector2.zero();
  ///-1 left , 1 right , 0 idle
  int _hAxisInput = 0;
  final double _moveSpeed = 200 ;
  final double _gravity = 10;
  final double _jumpSpeed = 320;
  bool _jumpInput = false;
  bool _isOnGround = false;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    add(CircleHitbox());
    return super.onLoad();
  }


  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  ///function to create all animation
  void _loadAllAnimation() {
    ///create animation based on image
    ///the image are saved in cache in the game Pixel adventure that we add it in HasGameRef<PixelAdventure>
    ///amount = number of item in animation image
    ///stepTime = how fast the images changes
    idleAnimation = _spriteAnimation(11, "Idle");
    runningAnimation = _spriteAnimation(12, "Run");
    jumpingAnimation = _spriteAnimation(1, "Jump");
    fallingAnimation = _spriteAnimation(1, "Fall");

    ///list of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running : runningAnimation,
      PlayerState.jumping : jumpingAnimation,
      PlayerState.falling : fallingAnimation,
    };
    ///set the current animation
    current = PlayerState.jumping;
  }

  ///function to create sprite animation
  SpriteAnimation _spriteAnimation(int amount, String state) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache("Main Characters/Virtual Guy/$state (32x32).png"),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: stepTime, textureSize: Vector2.all(32)));
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0 ;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowLeft)? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowRight)?  1 : 0;
    _jumpInput = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Platform){
      ///calculate collision
      if(intersectionPoints.length == 2){
        final mid = (intersectionPoints.elementAt(0) +
        intersectionPoints.elementAt(1)) / 2;
        final collisionNormal = absoluteCenter - mid ;
        final separationDistance = (size.x/2) - collisionNormal.length ;
        collisionNormal.normalized();
        if(Vector2(0,-1).dot(collisionNormal)>0.9){
          _isOnGround = true ;
        }
        position+= collisionNormal.normalized().scaled(separationDistance);
      }
    }
    if(other is Fruit){
      other.collidedWithPlayer();
    }
    super.onCollision(intersectionPoints, other);
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.jumping;
    //check if it face the right direction
    if (_velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else {
      if (_velocity.x > 0 && scale.x < 0) {
        flipHorizontallyAroundCenter();
      }
    }
    //check if moving  so we set running
    if (_velocity.x > 0 || _velocity.x < 0) playerState = PlayerState.running;
    //check if falling set to falling
    if (_velocity.y > 0 && !_isOnGround) playerState = PlayerState.falling;
    //check if jumping set to jumping
    if (_velocity.y < 0) playerState = PlayerState.jumping;
    current = playerState;
  }

  void _updatePlayerMovement(double dt) {
    _velocity.x = _hAxisInput * _moveSpeed ;
    _velocity.y += _gravity ;
    if(_jumpInput){
      if(_isOnGround){
        _velocity.y = -_jumpSpeed ;
        _isOnGround = false;
      }
      _jumpInput = false ;
    }
    ///to control the gravity between max and min value
    _velocity.y = _velocity.y.clamp(-_jumpSpeed, 150);
    position += _velocity * dt ;
  }

}