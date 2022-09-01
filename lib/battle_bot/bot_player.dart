import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'package:game_flame/battle_bot/helpers/atlas_helper.dart';
import 'package:game_flame/battle_bot/helpers/directions.dart';

class BotPlayer extends SpriteAnimationComponent with HasGameRef {
  BotPlayer() : super(size: Vector2.all(100.0));
  Direction direction = Direction.none;

  late final SpriteAnimation _walkingRightAnimation;
  late final SpriteAnimation _walkingLeftAnimation;
  late final SpriteAnimation _idleAnimation;

  final double _animationSpeed = .15;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _idleAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('spritesheet.png'),
        columns: 30,
        rows: 1);

    _idleAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, from: 0, to: 9);

    _walkingRightAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, from: 10, to: 19);

    _walkingLeftAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, from: 20, to: 29);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  updatePosition(double dt) {
    switch (direction) {
      case Direction.up:
        position.y--;
        break;
      case Direction.down:
        position.y++;
        break;
      case Direction.left:
        animation = _walkingLeftAnimation;
        position.x--;
        break;
      case Direction.right:
        animation = _walkingRightAnimation;
        position.x++;
        break;
      case Direction.none:
        animation = _idleAnimation;
        break;
    }
  }
}


class Sprites {
  late Map<String, Sprite> sprites;
  Sprites() {
    sprites = {};
  }

  Future<List<Sprite>> getStats(String name) async {
    List<Sprite> s = [];

    if (sprites.isEmpty) {
      sprites = await fromJSONAtlas('grits_effects.png', 'grits_effects.json');
    }

    sprites.forEach((key, value) {
      if (hasMatch(key, name)) s.add(value);
    });
    return s;
  }

  bool hasMatch(String s, String n) {
    RegExp r = RegExp("^$n(_\\d*)?.png");
    return r.hasMatch(s);
  }
}
