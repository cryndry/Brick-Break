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

enum PlayState { welcome, playing, gameOver, won }

class BrickBreak extends FlameGame with HasCollisionDetection, KeyboardEvents, TapDetector {
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

  final ValueNotifier<int> score = ValueNotifier(0);

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;
  }

  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Brick>());

    score.value = 0;
    playState = PlayState.playing;

    world.add(Ball(
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2(
          (rand.nextDouble() - 0.5) * width,
          height * 0.2,
        ).normalized()
          ..scale(height * 0.4)));

    bat = Bat(
      position: Vector2(gameWidth * 0.5, gameHeight - 64),
      size: Vector2(batWidth, batHeight),
    );
    world.add(bat);

    world.addAll([
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
  void onTap() {
    super.onTap();

    startGame();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        bat.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        bat.moveBy(batStep);
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.enter:
        startGame();
    }

    return KeyEventResult.handled;
  }
}
