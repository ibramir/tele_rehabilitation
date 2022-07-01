import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '/games/enemy.dart';
import 'bird_game.dart';
import '/games/audio_manager.dart';
import '/model/player_data.dart';

/// This enum represents the animation states of [Bird].
enum BirdAnimationStates {
  changeDir,
  fly,
  hit,
}

// This represents the Bird character of this game.
class Bird extends SpriteAnimationGroupComponent<BirdAnimationStates>
    with CollisionCallbacks, HasGameRef<Bird_Game> {
  // A map of all the animation states and their corresponding animations.
  static final _animationMap = {
    BirdAnimationStates.changeDir: SpriteAnimationData.sequenced(
      amount: 14,
      stepTime: 0.07,
      textureSize: Vector2(300, 300),
      texturePosition: Vector2(600, 0),
    ),
    BirdAnimationStates.fly: SpriteAnimationData.sequenced(
      amount: 16,
      stepTime: 0.07,
      textureSize: Vector2(300, 300),
      texturePosition: Vector2(0, 300),
    ),
    BirdAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 13,
      stepTime: 0.065,
      textureSize: Vector2(300, 300),
      texturePosition: Vector2(0, 600),
    ),
  };

  // Bird's current speed along y-axis.
  double speedY = 0;

  // Controlls how long the hit animations will be played.
  final Timer _hitTimer = Timer(1);
  final Timer _moveTimer = Timer(1);

  static const double gravity = 0.1;

  final PlayerData playerData;

  bool isHit = false;
  bool isUp = true;

  Bird(Image image, this.playerData)
      : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    // First reset all the important properties, because onMount()
    // will be called even while restarting the game.
    _reset();

    // Add a hitbox for bird.
    add(
      RectangleHitbox.relative(
        Vector2(0.4, 0.6),
        parentSize: size,
        position: Vector2(size.x * 0.4, size.y * 0.3) / 2,
      ),
    );

    /// Set the callback for [_hitTimer].
    _hitTimer.onTick = () {
      current = BirdAnimationStates.fly;
      isHit = false;
    };
    _moveTimer.onTick = () {
      current = BirdAnimationStates.fly;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    // isUp && !isUpperLan  -> going Up
    // !isUp && isUpperLan  -> Going down
    // Going Down, with min y = 140
    if (!isUp) {
      if (y < 160) {
        // v = u + at
        speedY += gravity * 1;
        // d = s0 + s * t
        y += speedY * 1;
      } else {
        y = 160;
      }
    }
    //  Going up, with max y = 80
    else if (isUp) {
      if (y > 70) {
        // v = u + at
        speedY += gravity * 1;
        // d = s0 + s * t
        y -= speedY * 1;
      } else {
        y = 70;
      }
    }

    _hitTimer.update(dt);
    _moveTimer.update(dt);
    super.update(dt);
  }

  // Gets called when bird collides with other Collidables.
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Call hit only if other component is an Enemy and bird
    // is not already in hit state.
    if ((other is Enemy) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  // Returns true if bird is on ground.
  // bool get isOnUpperLan => (y >= yMax);

  // Makes the bird jump.
  void changeDirection() {
    current = BirdAnimationStates.changeDir;
    if (isUp) {
      isUp = false;
    } else {
      isUp = true;
    }
    AudioManager.instance.playSfx('jump14.wav');
    _moveTimer.start();
  }

  // This method changes the animation state to
  /// [BirdAnimationStates.hit], plays the hit sound
  /// effect and reduces the player life by 1.
  void hit() {
    isHit = true;
    AudioManager.instance.playSfx('hurt7.wav');
    current = BirdAnimationStates.hit;
    _hitTimer.start();
    playerData.lives -= 1;
  }

  // This method reset some of the important properties
  // of this component back to normal.
  void _reset() {
    if (isMounted) {
      shouldRemove = false;
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(0, 70);
    size = Vector2(81.1, 70.2);
    current = BirdAnimationStates.fly;
    isHit = false;
    speedY = 0.0;
  }
}
