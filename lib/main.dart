import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_flame/ray_world_game/main_game_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RayWorld',
      home: MainGamePage(),
    );
  }
}
  // final game = BotGame();

  // WidgetsFlutterBinding.ensureInitialized();
  // await Flame.device.fullScreen();
  // await Flame.device.setPortrait();

  // runApp(GameWidget(game: game));
  // runApp(
  //   MaterialApp(
  //     home: Scaffold(
  //       body: Stack(children: [
  //         GameWidget(game: game),
  //         Align(
  //           alignment: Alignment.bottomRight,
  //           child: NavigationKeys(
  //             onDirectionChanged: game.onArrowKeyChanged,
  //           ),
  //         )
  //       ]),
  //     ),
  //   ),
  // );


// class BotGame extends FlameGame {
//   late SpriteAnimation bot;

//   @override
//   Future<void>? onLoad() async {
//     super.onLoad();
//     try {
//       final sp = Sprite();
//       final sprites = await sp.getStats(names.landmine_idle.name);

//       if (sprites.isNotEmpty) {
//         bot = SpriteAnimation.spriteList(sprites.toList(), stepTime: 0.1);
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     bot.update(dt);
//   }

//   @override
//   void render(Canvas c) {
//     super.render(c);
//     bot.getSprite().render(c);
//   }
// }
