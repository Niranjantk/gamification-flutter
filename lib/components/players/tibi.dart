import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:niranjanworld/components/player.dart';

class Tibi extends MyPlayer {
  Tibi({
    required startingPosition,
    animationName,
  }) : super(
          wattage: 500,
          imgPath: 'characters/tibi.png',
          startingPosition: startingPosition,
          collisionBox: Vector2(201, 136),
          positionCollisionBox: Vector2(50, -10),
          animationName: animationName,
        );
}
