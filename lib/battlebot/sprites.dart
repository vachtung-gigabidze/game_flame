import 'dart:async';
import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

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

  Future<Map<String, Sprite>> fromJSONAtlas(
      String imagePath, String dataPath) async {
    final String content = await Flame.assets.readFile(dataPath);
    final Map<String, dynamic> json = jsonDecode(content);

    final Map<String, dynamic> jsonFrames = json['frames'];
    final image = await Flame.images.load(imagePath);

    final sprites = jsonFrames.map((key, value) {
      final frameData = value['frame'];
      final int x = frameData['x'];
      final int y = frameData['y'];
      final int width = frameData['w'];
      final int height = frameData['h'];

      final Sprite sprite = Sprite(image,
          srcPosition: Vector2(x.toDouble(), y.toDouble()),
          srcSize: Vector2(width.toDouble(), height.toDouble()));
      return MapEntry(key, sprite);
    });

    return sprites;
  }
}

enum names {
  chaingun,
  chaingun_impact,
  chaingun_mask,
  chaingun_muzzle,
  chaingun_projectile,
  container_a,
  defensive_shield,
  energy_canister,
  grenade_launcher,
  health_canister,
  landmine,
  landmine_explosion,
  landmine_idle,
  landmine_impact,
  landmine_mask,
  legs,
  legs_player,
  machinegun,
  machinegun_impact,
  machinegun_mask,
  machinegun_muzzle,
  machinegun_projectile,
  offensive_shield,
  quad_damage,
  quad_effect,
  railgun,
  railgun_impact,
  railgun_mask,
  railgun_muzzle,
  railgun_projectile,
  rocket_launcher,
  shield_defensive,
  shield_offensive,
  shotgun,
  shotgun_impact,
  shotgun_mask,
  shotgun_muzzle,
  shotgun_projectile,
  spawner_black,
  spawner_white,
  teleporter_activate,
  teleporter_idle,
  thruster,
  thruster_mask,
  turret,
  turret_player,
  walk_down,
  walk_left,
  walk_right,
  walk_up
}
