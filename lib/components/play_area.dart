import 'dart:async';

import 'package:brick_breaker/brick_break.dart';
import 'package:brick_breaker/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayArea extends RectangleComponent with HasGameReference<BrickBreak> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(playAreaColor),
          children: [RectangleHitbox()],
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
