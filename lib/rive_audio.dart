import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class RiveAudioPlayer extends StatelessWidget {
  const RiveAudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rive Audio Player"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: _RiveAudioCard(
            assetPath: 'assets/audio.riv',
          ),
        ),
      ),
    );
  }
}

class _RiveAudioCard extends StatefulWidget {
  final String assetPath;

  const _RiveAudioCard({required this.assetPath});

  @override
  State<_RiveAudioCard> createState() => _RiveAudioCardState();
}

class _RiveAudioCardState extends State<_RiveAudioCard> {
  rive.RiveWidgetController? _controller;
  rive.ViewModelInstance? _viewModel;

  // Cached View Model Properties
  rive.ViewModelInstanceTrigger? _robot1Play;
  rive.ViewModelInstanceTrigger? _robot1Stop;
  rive.ViewModelInstanceTrigger? _robot2Play;
  rive.ViewModelInstanceTrigger? _robot2Stop;

  rive.ViewModelInstanceNumber? _robot1Volume;
  rive.ViewModelInstanceNumber? _robot2Volume;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onRiveInit(rive.RiveWidgetController controller) {
    _controller = controller;

    _viewModel = controller.dataBind(rive.DataBind.auto());

    if (_viewModel != null) {
      _robot1Play = _viewModel!.trigger("robot1play");
      _robot1Stop = _viewModel!.trigger("robot1stop");
      _robot2Play = _viewModel!.trigger("robot2play");
      _robot2Stop = _viewModel!.trigger("robot2stop");

      _robot1Volume = _viewModel!.number("robot1volume");
      _robot2Volume = _viewModel!.number("robot2volume");

      // Set default volumes
      _robot1Volume?.value = 100;
      _robot2Volume?.value = 100;
    }
  }

  void _playRobot1() => _robot1Play?.trigger();
  void _stopRobot1() => _robot1Stop?.trigger();
  void _playRobot2() => _robot2Play?.trigger();
  void _stopRobot2() => _robot2Stop?.trigger();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.cyan.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          // === Rive Animation Area ===
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: SizedBox(
              height: 320, // Fixed height for good visibility
              width: double.infinity,
              child: rive.RiveWidgetBuilder(
                fileLoader: rive.FileLoader.fromAsset(
                  widget.assetPath,
                  riveFactory: rive.Factory.rive,
                ),
                builder: (context, state) {
                  if (state is rive.RiveLoaded) {
                    _onRiveInit(state.controller);

                    return rive.RiveWidget(
                      controller: state.controller,
                      fit: rive.Fit.contain,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.cyan),
                  );
                },
              ),
            ),
          ),

          // === Control Buttons ===
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _playRobot1,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Robot 1 Play"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _stopRobot1,
                        icon: const Icon(Icons.stop),
                        label: const Text("Robot 1 Stop"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _playRobot2,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Robot 2 Play"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _stopRobot2,
                        icon: const Icon(Icons.stop),
                        label: const Text("Robot 2 Stop"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}