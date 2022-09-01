import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
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
}