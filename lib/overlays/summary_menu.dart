import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:niranjanworld/overlays/utils/hover_image.dart';
import 'package:niranjanworld/static/game_state.dart';
import 'package:niranjanworld/static/sound_player.dart';

// ignore: must_be_immutable
class SummaryMenu extends StatefulWidget {
  SummaryMenu(this.game, {super.key});
  Object? game;

  @override
  State<SummaryMenu> createState() => _SummaryMenuState();
}

class _SummaryMenuState extends State<SummaryMenu> {
  final Widget scoreTextGroup = Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
    child: SizedBox(
      height: 97,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Your Tower Consumes",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "TitleFont",
                  color: Color(0x50101120))),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/thunder_icon.png',
                height: 60,
              ),
              const SizedBox(width: 10),
              Text("${GameState.totalWattage.toString()}W",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 54,
                      fontFamily: "TitleFont",
                      color: Color(0xffffc51e))),
            ],
          ),
        ],
      ),
    ),
  );

  String getConclusionText() {
    final int totalWattage = GameState.totalWattage;
    if (totalWattage < 10000) {
      final double bulbs = totalWattage / 10;
      final String bulbsString = bulbs.toStringAsFixed(0);
      return "Just these house appliances consume in one hour as much electricity as $bulbsString LED light bulbs. Do not leave your toasters on!";
    }
    final double phones = totalWattage / 15;
    final String phonesString = phones.toStringAsFixed(0);
    return "In one hour, your tower consumes as much electricity as charging your phone $phonesString times. Do not leave your toasters on!";
  }

  Widget getConclusionTextWidgets() {
    final int totalWattage = GameState.totalWattage;
    if (totalWattage < 10000) {
      final double bulbs = totalWattage / 10;
      final String bulbsString = bulbs.toStringAsFixed(0);
      return Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text:
                  'Your ${GameState.score} appliances consumed in one hour as much electricity as ',
              style: TextStyle(color: Color.fromARGB(155, 16, 17, 32)),
            ),
            TextSpan(
              text: bulbsString,
              style: const TextStyle(
                color: Color.fromARGB(255, 253, 106, 96),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const TextSpan(
              text: ' LED light bulbs!',
              style: TextStyle(color: Color.fromARGB(155, 16, 17, 32)),
            ),
            const TextSpan(
              text: ' Turn off your appliances if you do not use them!',
              style: TextStyle(
                color: Color.fromARGB(96, 16, 17, 32),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.justify,
      );
    }
    final double phones = totalWattage / 15;
    final String phonesString = phones.toStringAsFixed(0);

    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text:
                'Your ${GameState.score} appliances consumed in one hour as much electricity as charging your phone ',
            style: TextStyle(color: Color.fromARGB(155, 16, 17, 32)),
          ),
          TextSpan(
            text: phonesString,
            style: const TextStyle(
              color: Color.fromARGB(255, 253, 106, 96),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const TextSpan(
            text: ' times!',
            style: TextStyle(color: Color.fromARGB(155, 16, 17, 32)),
          ),
          const TextSpan(
            text: ' Turn off your appliances if you do not use them!',
            style: TextStyle(
              color: Color.fromARGB(96, 16, 17, 32),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(127, 0, 0, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 20,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SizedBox(
                width: 350,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    scoreTextGroup,
                    Padding(
                        padding: const EdgeInsets.fromLTRB(29, 0, 29, 0),
                        child: getConclusionTextWidgets()),
                    HoverImage(
                      normalImage: 'assets/images/buttons/ok_up.png',
                      hoverImage: 'assets/images/buttons/ok_down.png',
                      onPressed: () {
                        (widget.game as FlameGame).overlays.remove('summary');
                        (widget.game as FlameGame).overlays.add('replay-menu');
                        SoundPlayer.playDrop();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
