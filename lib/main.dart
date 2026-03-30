import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart'; // Needed for Vector2

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

class Tiled extends FlameGame {
  late TiledComponent map;

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load('level1.tmx', Vector2.all(32));
    add(map);
  }
}