import 'package:flutter/material.dart';

class SmoothZoomArea extends StatefulWidget {
  final Widget child;

  const SmoothZoomArea({super.key, required this.child});

  @override
  _SmoothZoomAreaState createState() => _SmoothZoomAreaState();
}

class _SmoothZoomAreaState extends State<SmoothZoomArea>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  static const double _minScale = 0.1;
  static const double _maxScale = 3.0;
  static const double _zoomOutScale = 1.2;
  static const Duration _animationDuration = Duration(milliseconds: 200);

  bool get _isZoomedOut =>
      _controller.value.getMaxScaleOnAxis() > _zoomOutScale;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(_onAnimationControllerUpdate);
  }

  void _onAnimationControllerUpdate() {
    _controller.value = _animation.value;
  }

  void _onInteractionEnd(ScaleEndDetails details) {
    setState(() {});
  }

  void _animateScale(double targetScale) {
    final previousScale = _controller.value.getMaxScaleOnAxis();
    final currentScale = _controller.value;

    _animation = Matrix4Tween(
      begin: currentScale,
      end: currentScale * (targetScale / previousScale),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward(from: 0);
  }

  void _resetZoom() {
    _animateScale(1);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.value = Matrix4.identity();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
          transformationController: _controller,
          minScale: _minScale,
          maxScale: _maxScale,
          onInteractionEnd: _onInteractionEnd,
          child: widget.child,
        ),
        if (_isZoomedOut)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _resetZoom,
              backgroundColor: const Color.fromARGB(182, 0, 0, 0),
              child: const Icon(Icons.zoom_out_map),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
