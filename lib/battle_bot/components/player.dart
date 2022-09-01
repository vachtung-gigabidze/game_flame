import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class Player extends PositionComponent with HasGameRef {
  static const int squareSpeed = 250;
  static final squarePaint = BasicPalette.green.paint();
  static final squareWidth = 100.0, squareHeight = 100.0;
  late Rect squarePos;
  int squareDirection = 1;
  late double screenWidth, screenHeight, centerX, centerY;

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    squarePos =
        squarePos.translate(squareSpeed * squareDirection * deltaTime, 0);
    if (squareDirection == 1 && squarePos.right > screenWidth) {
      squareDirection = -1;
    } else if (squareDirection == -1 && squarePos.left < 0) {
      squareDirection = 1;
    }
  }

  // @override
  // void onCollision(Set<Vector2> points, Collidable other) {
  //   if (other is ScreenCollidable) {
  //     if (squareDirection == 1) {
  //       squareDirection = -1;
  //     } else {
  //       squareDirection = 1;
  //     }
  //   }
  // }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(squarePos, squarePaint);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;
    centerX = (screenWidth / 2) - (squareWidth / 2);
    centerY = (screenHeight / 2) - (squareHeight / 2);
    squarePos = Rect.fromLTWH(centerX, centerY, squareWidth, squareHeight);
  }
}
