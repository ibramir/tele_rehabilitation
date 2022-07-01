import 'dart:math';

import 'package:flame/components.dart';

import '/games/enemy.dart';
import 'bird_game.dart';
import '/model/enemy_data.dart';

// This class is responsible for spawning random enemies at certain
// interval of time depending upon players current score.
class EnemyManager extends Component with HasGameRef<Bird_Game> {
  // A list to hold data for all the enemies.
  final List<EnemyData> _data = [];

  // Random generator required for randomly selecting enemy type.
  final Random _random = Random();

  // Timer to decide when to spawn next enemy.
  final Timer _timer = Timer(2, repeat: true);

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
  }

  // This method is responsible for spawning a random enemy.
  void spawnRandomEnemy() {
    /// Generate a random index within [_data] and get an [EnemyData].
    final randomIndex = _random.nextInt(_data.length);
    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    // Help in setting all enemies on ground.
    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      gameRef.size.x + 32,
      gameRef.size.y - 24,
    );

    // If this enemy can fly, set its y position randomly.
    if (enemyData.canFly) {
      int min = 1;
      int max = 3;
      Random rnd = Random();
      Random varr = Random();
      int postion = min + rnd.nextInt(max - min);
      int newHeight = 80;
      switch (postion) {
        case 1:
          newHeight = 60 + varr.nextInt(20);
          break;
        case 2:
          newHeight = 120 + varr.nextInt(30);
          break;
        default:
      }

      enemy.position.y = newHeight * 1.0;
    }

    // Due to the size of our viewport, we can
    // use textureSize as size for the components.
    enemy.size = enemyData.textureSize * 1.5;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    if (isMounted) {
      shouldRemove = false;
    }

    // Don't fill list again and again on every mount.
    if (_data.isEmpty) {
      // As soon as this component is mounted, initilize all the data.
      _data.addAll([
        EnemyData(
          image: gameRef.images.fromCache('blue_Bird/Flying (32x32).png'),
          nFrames: 9,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
          speedX: 80,
          canFly: true,
        ),
        EnemyData(
          image: gameRef.images.fromCache('Bat/Flying (46x30).png'),
          nFrames: 7,
          stepTime: 0.1,
          textureSize: Vector2(46, 30),
          speedX: 100,
          canFly: true,
        ),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = gameRef.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
