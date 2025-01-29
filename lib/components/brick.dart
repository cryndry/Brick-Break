import 'package:brick_breaker/brick_break.dart';
import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/components/bat.dart';
import 'package:brick_breaker/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';


class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameReference<BrickBreak> {
  Brick({required super.position, required Color color})
      : super(
          size: Vector2(brickWidth, brickHeight),
          anchor: Anchor.center,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
          children: [RectangleHitbox()],
        );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    removeFromParent(); // remove the brick

    if (game.world.children.query<Brick>().length == 1) {
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }
}