import 'package:tele_rehabilitation/exercises/verify_pose.dart';
import 'package:tele_rehabilitation/games/bird.dart';
import 'package:flame/game.dart';
import 'package:hive/hive.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:tele_rehabilitation/model/exercise.dart';

import '../widgets/game_world.dart';
import '/model/settings.dart';
import '/games/audio_manager.dart';
import '/games/enemy_manager.dart';
import '/model/player_data.dart';
import '/widgets/pause_menu.dart';
import '/widgets/game_over_menu.dart';

// This is the main flame game class.
class BirdGame extends FlameGame with HasCollisionDetection {
  BirdGame(this._exercise) {
    _exercise.addListener(_listener);
    _verifyPose = VerifyPose(_exercise);
  }

  final Exercise _exercise;
  late final VerifyPose _verifyPose;

  void _listener() {
    _bird.changeDirection();
  }

  // List of all the image assets.
  static const _imageAssets = [
    'Bird.png',
    'blue_Bird/Flying (32x32).png',
    'Bat/Flying (46x30).png',
    'parallax/sky.png',
    'parallax/clouds_1.png',
    'parallax/clouds_2.png',
    'parallax/clouds_3.png',
    'parallax/clouds_4.png',
    'parallax/rocks_1.png',
    'parallax/rocks_2.png',
  ];

  // List of all the audio assets.
  static const _audioAssets = [
    '8Bit Platformer Loop.wav',
    'hurt7.wav',
    'jump14.wav',
  ];

  late Bird _bird;
  late Settings settings;
  late PlayerData playerData;
  late EnemyManager _enemyManager;

  // This method get called while flame is preparing this game.
  @override
  Future<void> onLoad() async {
    /// Read [PlayerData] and [Settings] from hive.
    playerData = await _readPlayerData();
    settings = await _readSettings();

    /// Initilize [AudioManager].
    await AudioManager.instance.init(_audioAssets, settings);

    // Start playing background music. Internally takes care
    // of checking user settings.
    AudioManager.instance.startBgm('8Bit Platformer Loop.wav');

    // Cache all the images.
    await images.loadAll(_imageAssets);

    // Set a fixed viewport to avoid manually scaling
    // and handling different screen sizes.
    camera.viewport = FixedResolutionViewport(Vector2(360, 180));

    /// Create a [ParallaxComponent] and add it to game.
    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/sky.png'),
        ParallaxImageData('parallax/clouds_1.png'),
        ParallaxImageData('parallax/clouds_2.png'),
        ParallaxImageData('parallax/clouds_3.png'),
        ParallaxImageData('parallax/clouds_4.png'),
        ParallaxImageData('parallax/rocks_1.png'),
        ParallaxImageData('parallax/rocks_2.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );
    add(parallaxBackground);

    return super.onLoad();
  }

  /// This method add the already created [Bird]
  /// and [EnemyManager] to this game.
  void startGamePlay() {
    _bird = Bird(images.fromCache('Bird.png'), playerData);
    _enemyManager = EnemyManager();
    add(_bird);
    add(_enemyManager);
    _verifyPose.initPoseVerification();
  }

  // This method remove all the actors from the game.
  void _disconnectActors() {
    _bird.removeFromParent();
    _enemyManager.removeAllEnemies();
    _enemyManager.removeFromParent();
  }

  // This method reset the whole game world to initial state.
  void reset() {
    // First disconnect all actions from game world.
    _disconnectActors();

    // Reset player data to inital values.
    playerData.currentScore = 0;
    playerData.lives = 5;
  }

  // This method gets called for each tick/frame of the game.
  @override
  void update(double dt) {
    // If number of lives is 0 or less, game is over.
    if (playerData.lives <= 0) {
      overlays.add(GameOverMenu.id);
      overlays.remove(GameWorld.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
      _verifyPose.closePoseVerification();
      _exercise.removeListener(_listener);
    }
    super.update(dt);
  }

  /// This method reads [PlayerData] from the hive box.
  Future<PlayerData> _readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>('BirdRun.PlayerDataBox');
    final playerData = playerDataBox.get('BirdRun.PlayerData');

    // If data is null, this is probably a fresh launch of the game.
    if (playerData == null) {
      // In such cases store default values in hive.
      await playerDataBox.put('BirdRun.PlayerData', PlayerData());
    }

    // Now it is safe to return the stored value.
    return playerDataBox.get('BirdRun.PlayerData')!;
  }

  /// This method reads [Settings] from the hive box.
  Future<Settings> _readSettings() async {
    final settingsBox = await Hive.openBox<Settings>('BirdRun.SettingsBox');
    final settings = settingsBox.get('BirdRun.Settings');

    // If data is null, this is probably a fresh launch of the game.
    if (settings == null) {
      // In such cases store default values in hive.
      await settingsBox.put(
        'BirdRun.Settings',
        Settings(bgm: true, sfx: true),
      );
    }

    // Now it is safe to return the stored value.
    return settingsBox.get('BirdRun.Settings')!;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // On resume, if active overlay is not PauseMenu,
        // resume the engine (lets the parallax effect play).
        if (!(overlays.isActive(PauseMenu.id)) &&
            !(overlays.isActive(GameOverMenu.id))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        // If game is active, then remove Hud and add PauseMenu
        // before pausing the game.
        if (overlays.isActive(GameWorld.id)) {
          overlays.remove(GameWorld.id);
          overlays.add(PauseMenu.id);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
