import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class WorldCollidable extends PositionComponent
    with HasGameRef, CollisionCallbacks {
  WorldCollidable() {
    add(RectangleHitbox());
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {}

  // @override
  // void onCollisionEnd(PositionComponent other) {}

}
