import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_flame/dino/dino_game.dart';
import 'package:game_flame/dino/helpers/navigation_keys.dart';
//import 'package:game_flame/battlebot/sprites.dart';

void main() {
  final game = DinoGame();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          GameWidget(game: game),
          Align(
            alignment: Alignment.bottomRight,
            child: NavigationKeys(
              onDirectionChanged: game.onArrowKeyChanged,
            ),
          )
        ]),
      ),
    ),
  );
}

class Game extends FlameGame {
  //late SpriteAnimation bot;

  // @override
  // Future<void>? onLoad() async {
  //   super.onLoad();
  //   try {
  //     final sp = Sprites();
  //     final sprites = await sp.getStats(names.landmine_idle.name);

  //     if (sprites.isNotEmpty) {
  //       bot = SpriteAnimation.spriteList(sprites.toList(), stepTime: 0.1);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   bot.update(dt);
  // }

  // @override
  // void render(Canvas c) {
  //   super.render(c);
  //   bot.getSprite().render(c);
  // }
}
