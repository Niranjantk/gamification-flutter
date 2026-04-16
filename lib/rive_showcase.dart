import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class RiveShowcase extends StatelessWidget {
  const RiveShowcase({super.key});

  void _handleTap(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped $title!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF4EEBFB).withValues(alpha: 0.8),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F0F1A), Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 40, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RIVE NATIVE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4EEBFB),
                          letterSpacing: 3,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Animation Showcase',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Powered by high-performance native C++ runtime. Tap the cards to interact.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white54,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _RiveCard(
                      title: 'Interactive Button',
                      assetPath: 'assets/button.riv',
                      description:
                          'Triggers "Button Trig" state machine input on tap.',
                      accentColor: const Color(0xFF4EEBFB),
                      onTap: () => _handleTap(context, 'Interactive Button'),
                    ),
                    const SizedBox(height: 32),
                    _RiveCard(
                      title: 'Audio Visualizer',
                      assetPath: 'assets/audio.riv',
                      description: 'Dynamic animation with playback controls.',
                      accentColor: const Color(0xFFFF4E88),
                      onTap: () => _handleTap(context, 'Audio Visualizer'),
                    ),
                    const SizedBox(height: 40),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiveCard extends StatefulWidget {
  final String title;
  final String assetPath;
  final String description;
  final Color accentColor;
  final VoidCallback? onTap;

  const _RiveCard({
    required this.title,
    required this.assetPath,
    required this.description,
    required this.accentColor,
    this.onTap,
  });

  @override
  State<_RiveCard> createState() => _RiveCardState();
}

class _RiveCardState extends State<_RiveCard> {
  late final rive.FileLoader _fileLoader;
  rive.RiveWidgetController? _controller;

  @override
  void initState() {
    super.initState();
    _fileLoader = rive.FileLoader.fromAsset(
      widget.assetPath,
      riveFactory: rive.Factory.rive,
    );
  }

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  void _triggerInput() {
    final controller = _controller;
    if (controller == null) return;

    // Trigger state machine inputs using the correct native 0.14+ API
    // Accessing the stateMachine property from the RiveWidgetController
    controller.stateMachine.trigger('Button Trig')?.fire();

    // Also call the provided callback for Flutter feedback
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerInput,
      child: Container(
        height: 380,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                  ),
                  child: rive.RiveWidgetBuilder(
                    fileLoader: _fileLoader,
                    builder: (context, state) {
                      if (state is rive.RiveLoaded) {
                        _controller = state.controller;
                        return rive.RiveWidget(
                          controller: state.controller,
                          fit: rive.Fit.contain,
                        );
                      } else if (state is rive.RiveFailed) {
                        _controller = null;
                        return Center(
                          child: Text(
                            'Load Failed: ${state.error}',
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        );
                      }
                      _controller = null;
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white24),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.accentColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.accentColor.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.touch_app_rounded,
                        color: widget.accentColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
