import 'dart:async';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: Tiled(),
        ),
      ),
    );
  }
}

class Tiled extends FlameGame with HasGameRef<Tiled>, TapCallbacks, KeyboardEvents {
  late TiledComponent map;
  late Player player;
  late NPC npc;
  DialogBox? dialogBox;
  TalkButton? talkButton;

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load('level1.tmx', Vector2.all(32));
    add(map);

    player = Player();
    add(player);

    npc = NPC();
    add(npc);

    // Add HUD buttons for movement
    add(MovementButton(
      positionOffset: Vector2(32, game.size.y - 100),
      onPressed: () => player.horizontalMovement = -1,
      onReleased: () => player.horizontalMovement = 0,
      label: '<',
    ));

    add(MovementButton(
      positionOffset: Vector2(110, game.size.y - 100),
      onPressed: () => player.horizontalMovement = 1,
      onReleased: () => player.horizontalMovement = 0,
      label: '>',
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Proximity check
    final distance = player.position.distanceTo(npc.position);
    if (distance < 60) {
      if (talkButton == null) {
        talkButton = TalkButton(npc: npc);
        add(talkButton!);
      }
    } else {
      if (talkButton != null) {
        remove(talkButton!);
        talkButton = null;
      }
      if (dialogBox != null) {
        remove(dialogBox!);
        dialogBox = null;
      }
    }
  }

  void showDialog() {
    if (dialogBox == null) {
      dialogBox = DialogBox(text: "Hello explorer! Welcome to this mysterious world.\nAre you ready for your adventure?");
      add(dialogBox!);
    }
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    player.move(keysPressed);
    return KeyEventResult.handled;
  }
}

enum PlayerState { idle, walk }

class Player extends SpriteAnimationGroupComponent<PlayerState> with HasGameRef<Tiled> {
  final double speed = 150;
  Vector2 velocity = Vector2.zero();
  double horizontalMovement = 0;
  double verticalMovement = 0;

  @override
  Future<void> onLoad() async {
    final idleAnimation = await game.loadSpriteAnimation(
      'idle.png',
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.1,
        textureSize: Vector2(46, 55),
      ),
    );

    final walkAnimation = await game.loadSpriteAnimation(
      'walk.png',
      SpriteAnimationData.sequenced(
        amount: 24,
        stepTime: 0.05,
        textureSize: Vector2(45, 58), // 180/4 x 348/6
      ),
    );

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walk: walkAnimation,
    };

    current = PlayerState.idle;
    size = Vector2(46, 55);
    position = Vector2(100, 100);
    anchor = Anchor.center; // Better for flipping
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Combine keyboard and button movement
    velocity.x = horizontalMovement * speed;
    velocity.y = verticalMovement * speed;

    if (velocity.isZero()) {
      current = PlayerState.idle;
    } else {
      current = PlayerState.walk;
      position += velocity * dt;
      
      // Flip sprite based on direction
      if (velocity.x < 0 && scale.x > 0) {
        flipHorizontallyAroundCenter();
      } else if (velocity.x > 0 && scale.x < 0) {
        flipHorizontallyAroundCenter();
      }
    }
  }

  void move(Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    verticalMovement = 0;
    
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalMovement = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalMovement = 1;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      verticalMovement = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      verticalMovement = 1;
    }
  }
}

class NPC extends SpriteAnimationComponent with HasGameRef<Tiled> {
  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'idle.png', // Use same idle for now
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.15, // Slower idle
        textureSize: Vector2(46, 55),
      ),
    );
    size = Vector2(46, 55);
    position = Vector2(250, 100);
    // Tint NPC slightly blue to distinguish
    paint = Paint()..colorFilter = const ColorFilter.mode(Colors.blueAccent, BlendMode.modulate);
  }
}

class TalkButton extends PositionComponent with HasGameRef<Tiled>, TapCallbacks {
  final NPC npc;
  TalkButton({required this.npc});

  @override
  Future<void> onLoad() async {
    size = Vector2(60, 24);
    position = npc.position + Vector2(npc.size.x / 2 - size.x / 2, -30);
    
    add(
      RectangleComponent(
        size: size,
        paint: Paint()..color = Colors.black.withOpacity(0.6),
        children: [
          TextComponent(
            text: 'Talk (Tap)',
            position: size / 2,
            anchor: Anchor.center,
            textRenderer: TextPaint(
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )..anchor = Anchor.topLeft,
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.showDialog();
  }
}

class MovementButton extends PositionComponent with HasGameRef<Tiled>, TapCallbacks {
  final VoidCallback onPressed;
  final VoidCallback onReleased;
  final String label;
  final Vector2 positionOffset;

  MovementButton({
    required this.positionOffset,
    required this.onPressed,
    required this.onReleased,
    required this.label,
  });

  @override
  Future<void> onLoad() async {
    size = Vector2(60, 60);
    // Position relative to the screen, not the map
    // We'll update position in update to stay fixed if camera moves, 
    // or better, use a viewport-based approach.
    // For now, let's just use the absolute position.
    position = positionOffset;
    
    add(
      CircleComponent(
        radius: 30,
        paint: Paint()..color = Colors.white.withOpacity(0.3),
      ),
    );

    add(
      TextComponent(
        text: label,
        position: Vector2(30, 30),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Keep fixed on screen by following camera (basic implementation)
    // In a full implementation, this should be added to camera.viewport
  }

  @override
  void onTapDown(TapDownEvent event) {
    onPressed();
  }

  @override
  void onTapUp(TapUpEvent event) {
    onReleased();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    onReleased();
  }
}

class DialogBox extends PositionComponent with HasGameRef<Tiled> {
  final String text;
  DialogBox({required this.text});

  @override
  Future<void> onLoad() async {
    size = Vector2(game.size.x * 0.8, 100);
    position = Vector2(game.size.x * 0.1, game.size.y - 120);
    
    // Background with rounded corners aesthetic
    final background = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.black.withOpacity(0.8),
    );
    add(background);

    // Border
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = Colors.blueAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      ),
    );

    add(
      TextBoxComponent(
        text: text,
        position: Vector2(20, 20),
        size: size - Vector2(40, 40),
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.5,
            fontFamily: 'Courier', // "3D game" feel
          ),
        ),
        boxConfig: TextBoxConfig(timePerChar: 0.05), // Typewriter effect
      ),
    );
  }
}