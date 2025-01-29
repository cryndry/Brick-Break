import 'package:brick_breaker/brick_break.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = BrickBreak();
  runApp(GameWidget(game: game));
}