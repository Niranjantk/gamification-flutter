import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:niranjanworld/components/player.dart';

class Toaster extends MyPlayer {
  Toaster({
    required startingPosition,
    animationName,
  }) : super(
          wattage: 1200,
          imgPath: 'characters/toaster.png',
          startingPosition: startingPosition,
          collisionBox: Vector2(201, 125),
          positionCollisionBox: Vector2(50, -20),
          animationName: animationName,
        );
}
