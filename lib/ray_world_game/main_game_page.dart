import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_flame/ray_world_game/ray_world_game.dart';
import 'helpers/direction.dart';
import 'helpers/joypad.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  RayWorldGame game = RayWorldGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(game: game),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.chat,
                  size: 28.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.heart_broken,
                      size: 28.0,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.heart_broken,
                      size: 28.0,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.heart_broken,
                      size: 22.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Joypad(
                  onDirectionChanged: onJoypadDirectionChanged,
                  onOffsetChanged: onJoypadOffsetChanged,
                ),
              ),
            )
          ],
        ));
  }

  void onJoypadDirectionChanged(Direction direction) {
    game.onJoypadDirectionChanged(direction);
  }

  void onJoypadOffsetChanged(Offset offset) {
    // log(offset.toString());
    game.onJoypadOffsetChanged(offset);
  }
}
