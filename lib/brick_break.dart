import 'dart:async';
import 'dart:math' as math;

import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/components/bat.dart';
import 'package:brick_breaker/components/brick.dart';
import 'package:brick_breaker/components/play_area.dart';
import 'package:brick_breaker/config.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrickBreak extends FlameGame with HasCollisionDetection, KeyboardEvents {
  BrickBreak()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  late Bat bat;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    world.add(Ball(
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2(
          (rand.nextDouble() - 0.5) * width,
          height * 0.2,
        ).normalized()
          ..scale(height / 4)));

    bat = Bat(
      position: Vector2(gameWidth * 0.5, gameHeight - 64),
      size: Vector2(batWidth, batHeight),
    );
    world.add(bat);

    await world.addAll([
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: Color(brickColors[rand.nextInt(brickColors.length)]),
          ),
    ]);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        bat.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        bat.moveBy(batStep);
    }

    return KeyEventResult.handled;
  }
}
