import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:game_flame/battle_bot/components/player.dart';

class BotGame extends FlameGame with HasCollisionDetection {
  static const int squareSpeed = 250;
  static final squarePaint = BasicPalette.green.paint();
  static final squareWidth = 100.0, squareHeight = 100.0;
  late Rect squarePos;
  int squareDirection = 1;
  late double screenWidth, screenHeight, centerX, centerY;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Player());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(squarePos, squarePaint);
  }

  @override
  void update(double deltaTime) {
    squarePos =
        squarePos.translate(squareSpeed * squareDirection * deltaTime, 0);
    if (squareDirection == 1 && squarePos.right > screenWidth) {
      squareDirection = -1;
    } else if (squareDirection == -1 && squarePos.left < 0) {
      squareDirection = 1;
    }
  }
}


// class BotGame extends FlameGame {
//   BotPlayer _botPlayer = BotPlayer();
//   BotWorld _botWorld = BotWorld();
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     await add(_botWorld);
//     await add(_botPlayer);
//     _botPlayer.position = _botWorld.size / 1.5;
//     camera.followComponent(_botPlayer,
//         worldBounds: Rect.fromLTRB(0, 0, _botPlayer.size.x, _botPlayer.size.y));
//   }

//   onArrowKeyChanged(Direction direction) {
//     _botPlayer.direction = direction;
//   }
// }
