import 'dart:developer';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_flame/ray_world_game/components/player.dart';
import 'package:game_flame/ray_world_game/components/world.dart';
import 'package:game_flame/ray_world_game/components/world_collidable.dart';
import 'package:game_flame/ray_world_game/helpers/direction.dart';
import 'package:game_flame/ray_world_game/helpers/map_loader.dart';

class RayWorldGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Player _player = Player();
  final World _world = World();

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  void onJoypadOffsetChanged(Offset offset) {
    _player.offset = offset;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    add(_player);
    addWorldCollision();
    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection = null;
    log(event.logicalKey.toString());
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      keyDirection = Direction.down;
    }

    if (isKeyDown && keyDirection != null) {
      _player.direction = keyDirection;
    } else if (_player.direction == keyDirection) {
      _player.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
