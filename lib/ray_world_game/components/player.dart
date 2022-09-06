import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:game_flame/ray_world_game/components/world_collidable.dart';
import 'package:game_flame/ray_world_game/helpers/direction.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  Direction direction = Direction.none;
  Offset offset = const Offset(0, 0);
  final double _playerSpeed = 300.0;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  Player()
      : super(
          size: Vector2.all(80.0),
        ) {
    add(RectangleHitbox());
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is WorldCollidable) {
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    _hasCollided = false;
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  @override
  void update(double dt) {
    super.update(dt);
    movePlayer(offset);
  }

  // void movePlayer(double delta) {
  void movePlayer(Offset delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          // moveUp(delta);
          moveOffset(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          //moveDown(delta);
          moveOffset(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          // moveLeft(delta);
          moveOffset(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          // moveRight(delta);
          moveOffset(delta);
        }
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }

  // void moveDown(Offset delta) {
  //   // position.add(Vector2(0, delta.dx * _playerSpeed));
  //   position.add(Vector2(delta.dx, delta.dy));
  // }

  void moveOffset(Offset delta) {
    position.add(Vector2(delta.dx / 5, delta.dy / 5));
  }

  // void moveUp(Offset delta) {
  //   position.add(Vector2(0, delta.dx * _playerSpeed * -1));
  // }

  // void moveLeft(Offset delta) {
  //   position.add(Vector2(delta.dx * _playerSpeed * -1, 0));
  // }

  // void moveRight(Offset delta) {
  //   position.add(Vector2(delta.dx * _playerSpeed, 0));
  // }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet2.png'),
      //srcSize: Vector2(29.0, 32.0),
      srcSize: Vector2(203, 224),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);
    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }
}
