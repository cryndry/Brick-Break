import 'package:brick_breaker/brick_break.dart';
import 'package:brick_breaker/components/bat.dart';
import 'package:brick_breaker/components/play_area.dart';
import 'package:brick_breaker/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent with CollisionCallbacks, HasGameRef<BrickBreak> {
  Ball({
    required this.velocity,
    required super.position,
    required super.radius,
  }) : super(
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(ballColor)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );

  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y *= -1;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x *= -1;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x *= -1;
      } else if (intersectionPoints.first.y >= game.height) {
        removeFromParent(); // game over
      }
    } else if (other is Bat) {
      velocity.y *= -1;
      velocity.x += (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else {
      debugPrint('collision with $other');
    }
  }
}
