import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A reusable widget that wraps its [child] with a scroll-triggered
/// fade + slide-up entrance animation.
///
/// When the widget becomes >= 20% visible in the viewport, the animation
/// plays: fade 0→1 and translateY +40→0, over 600 ms (Curves.easeOutCubic).
///
/// Use the [delay] parameter for staggered effects.
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double visibilityThreshold;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.visibilityThreshold = 0.2,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  bool _hasAnimated = false;
  final String _visibilityKey = UniqueKey().toString();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08), // ~40px at typical font-size scale
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasAnimated &&
        info.visibleFraction >= widget.visibilityThreshold) {
      _hasAnimated = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(_visibilityKey),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      ),
    );
  }
}

