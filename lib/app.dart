import 'package:brick_breaker/brick_break.dart';
import 'package:brick_breaker/components/overlay.dart';
import 'package:brick_breaker/components/score.dart';
import 'package:brick_breaker/config.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  late final BrickBreak game;

  @override
  void initState() {
    super.initState();
    game = BrickBreak();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Score(score: game.score),
                  Expanded(
                    child: FittedBox(
                      child: SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: GameWidget(
                          game: game,
                          overlayBuilderMap: {
                            PlayState.welcome.name: (context, game) => const OverlayScreen(
                                  title: 'TAP TO PLAY',
                                  subtitle: 'Use arrow keys or swipe',
                                ),
                            PlayState.gameOver.name: (context, game) => const OverlayScreen(
                                  title: 'G A M E   O V E R',
                                  subtitle: 'Tap to Play Again',
                                ),
                            PlayState.won.name: (context, game) => const OverlayScreen(
                                  title: 'Y O U   W O N ! ! !',
                                  subtitle: 'Tap to Play Again',
                                ),
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
