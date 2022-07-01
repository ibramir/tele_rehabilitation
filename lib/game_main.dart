import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'widgets/game_world.dart';
import 'widgets/main_menu.dart';
import 'widgets/pause_menu.dart';
import 'widgets/settings_menu.dart';
import 'widgets/game_over_menu.dart';
import 'game/bird_game.dart';

/// This is the single instance of [Bird_Game] which
/// will be reused throughout the lifecycle of the game.
Bird_Game _game = Bird_Game();

// The main widget for this game.
class BirdRunApp extends StatelessWidget {
  const BirdRunApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bird Run',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Settings up some default theme for elevated buttons.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: const Size(200, 60),
          ),
        ),
      ),
      home: Scaffold(
        body: GameWidget(
          // This will dislpay a loading bar until [BirdRunApp] completes
          // its onLoad method.
          loadingBuilder: (conetxt) => const Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),
          // Register all the overlays that will be used by this game.
          overlayBuilderMap: {
            MainMenu.id: (_, Bird_Game gameRef) => MainMenu(gameRef),
            PauseMenu.id: (_, Bird_Game gameRef) => PauseMenu(gameRef),
            Game_world.id: (_, Bird_Game gameRef) => Game_world(gameRef),
            GameOverMenu.id: (_, Bird_Game gameRef) => GameOverMenu(gameRef),
            SettingsMenu.id: (_, Bird_Game gameRef) => SettingsMenu(gameRef),
          },
          // By default MainMenu overlay will be active.
          initialActiveOverlays: const [MainMenu.id],
          game: _game,
        ),
      ),
    );
  }
}
