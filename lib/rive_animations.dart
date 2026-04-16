import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:rivegame/rive_audio.dart';

class RiveAnimations extends StatelessWidget {
  const RiveAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Navigate to audio player
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RiveAudioPlayer()),
          );
        },
        child: const Icon(Icons.navigate_next),
      ),
      appBar: AppBar(title: const Text("Rive Button Animation")),
      body: Center(
        child: _RiveButtonCard(
          assetPath: 'assets/button.riv',
          accentColor: const Color(0xFF4EEBFB),
        ),
      ),
    );
  }
}

class _RiveButtonCard extends StatefulWidget {
  final String assetPath;
  final Color accentColor;

  const _RiveButtonCard({
    required this.assetPath,
    required this.accentColor,
  });

  @override
  State<_RiveButtonCard> createState() => _RiveButtonCardState();
}

class _RiveButtonCardState extends State<_RiveButtonCard> {
  rive.RiveWidgetController? _controller;
  rive.ViewModelInstance? _viewModel;

  // Cache your View Model properties
  rive.ViewModelInstanceTrigger? _buttonTrigger;
  rive.ViewModelInstanceBoolean? _buttonBool;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// Called when the Rive file is loaded and controller is ready
  void _onRiveInit(rive.RiveWidgetController controller) {
    _controller = controller;

    // === Correct way to bind View Model (Data Binding) ===
    _viewModel = controller.dataBind(rive.DataBind.auto());

    if (_viewModel != null) {
      _buttonTrigger = _viewModel!.trigger("");   // ← Use exact name from Rive Editor
      _buttonBool = _viewModel!.boolean("");     // ← Use exact name from Rive Editor
    }
  }

  void _triggerAnimation() {
    // Trigger (one-shot action)
    _buttonTrigger?.trigger();        // ← This is the correct method (not .fire())

    // Toggle Boolean (if you have one)
    if (_buttonBool != null) {
      _buttonBool!.value = !_buttonBool!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerAnimation,
      child: Container(
        height: 380,
        width: double.infinity,
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: widget.accentColor.withOpacity(0.3)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: rive.RiveWidgetBuilder(
            fileLoader: rive.FileLoader.fromAsset(widget.assetPath,riveFactory: rive.Factory.rive),
            builder: (context, state) {
              if (state is rive.RiveLoaded) {
                _onRiveInit(state.controller);   // Important: init here

                return rive.RiveWidget(
                  controller: state.controller,
                  fit: rive.Fit.contain,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}