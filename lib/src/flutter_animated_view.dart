import 'dart:async';

import 'package:flutter/material.dart';

enum AnimationType {
  none,
  fadeIn,
  scale,
  slideRTL,
  slideLTR,
  slideUp,
  flip,
  bounce,
  scaleLTR, // New animation type for scaling from left to right
  scaleCenterZoomOut, // New animation type for centering circular view
}

class FlutterAnimatedView extends StatefulWidget {
  final Widget child;

  final AnimationType animationType;

  /// default duration Duration(milliseconds: 500).
  final Duration duration;

  // default curve value Curves.easeInOut
  final Curve curve;

  final int? index;

  /// default repeatMode value: false.
  final bool repeatMode;

  /// default delay between multiple animations
  final Duration delayBetweenAnimation;

  const FlutterAnimatedView({
    super.key,
    required this.child,
    this.index,
    this.animationType = AnimationType.slideRTL,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.repeatMode = false,
    this.delayBetweenAnimation = const Duration(milliseconds: 50),
  });

  @override
  FlutterAnimatedViewState createState() => FlutterAnimatedViewState();
}

class FlutterAnimatedViewState extends State<FlutterAnimatedView> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  Animation<double>? _fadeAnimation;
  Animation<double>? _scaleAnimation;
  Animation<Offset>? _slideAnimation;
  Animation<Offset>? _slideUpAnimation;
  Animation<double>? _flipAnimation;
  Animation<double>? _bounceAnimation;
  bool isAnimationOn = true; // ANIMATION REMOVE FROM ENTER APP WHERE WIDGET USED.

  // bool _hasAnimated = false;
  bool _wantKeepAlive = false;
  late AnimationType animationType;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Initialize animations based on animation type
    _wantKeepAlive = !widget.repeatMode;
    animationType = widget.animationType;

    if (!isAnimationOn) {
      animationType = AnimationType.none;
    }
    _initAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlutterAnimatedView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animationType != oldWidget.animationType) {
      // _hasAnimated = false; // Reset animation flag on animation type change
      _initAnimations(); // Reinitialize animations if animation type changes
    }
  }

  void _initAnimations() {
    switch (animationType) {
      case AnimationType.none:
        break;
      case AnimationType.bounce:
        _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.bounceIn, // Apply bounce effect
          ),
        );
        break;
      case AnimationType.fadeIn:
        _fadeAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
        break;
      case AnimationType.scale:
        _scaleAnimation = Tween<double>(
          begin: 0.5,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
        break;
      case AnimationType.slideRTL:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(1, 0), // Slide from right (1) to left (0)
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
        break;
      case AnimationType.slideLTR:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(-1, 0), // Slide from left (-1) to right (0)
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
        break;
      case AnimationType.flip:
        _flipAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
        break;
      case AnimationType.slideUp:
        _slideUpAnimation = Tween<Offset>(
          begin: const Offset(0.0, 1.0), // Offscreen bottom
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
        break;

      case AnimationType.scaleLTR: // Scale from left to right
        _scaleAnimation = Tween<double>(begin: 0.0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
        break;
      case AnimationType.scaleCenterZoomOut:
        _scaleAnimation = Tween<double>(
          begin: 0.0, // Start from full size (visible)
          end: 1.0, // End at zero scale (invisible)
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );

        break;
    }

    // Start animation only once per item load
    //if (!_hasAnimated) {
    Timer(widget.index != null ? Duration(milliseconds: (100 * ((widget.index ?? 0) % 12))) : widget.delayBetweenAnimation, () async {
      _controller.forward();

      // _hasAnimated = true;
    });
    //}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget animatedWidget = widget.child;

    if (_fadeAnimation != null) {
      animatedWidget = FadeTransition(
        opacity: _fadeAnimation!,
        child: widget.child,
      );
    } else if (_scaleAnimation != null) {
      animatedWidget = ScaleTransition(
        scale: _scaleAnimation!,
        child: widget.child,
      );
    } else if (_slideAnimation != null) {
      animatedWidget = SlideTransition(
        position: _slideAnimation!,
        child: widget.child,
      );
    } else if (_slideUpAnimation != null) {
      animatedWidget = SlideTransition(
        position: _slideUpAnimation!,
        child: widget.child,
      );
    } else if (_bounceAnimation != null) {
      animatedWidget = AnimatedBuilder(
        animation: _bounceAnimation!,
        builder: (context, child) {
          // Calculate the scale based on the animation value
          double scale = 1.5 - (_bounceAnimation!.value * 0.5);
          // Ensure scale stays within bounds (1.0 to 1.5)
          scale = scale.clamp(1.0, 1.5);

          return Transform.scale(
            scale: scale,
            child: widget.child,
          );
        },
      );
    } else if (_flipAnimation != null) {
      animatedWidget = AnimatedBuilder(
        animation: _flipAnimation!,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(_flipAnimation!.value * -3.1415927), // radians
            alignment: FractionalOffset.center,
            child: widget.child,
          );
        },
      );
    } else if (animationType == AnimationType.scaleLTR) {
      animatedWidget = AnimatedBuilder(
        animation: _scaleAnimation!,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation!.value,
            alignment: Alignment.centerLeft,
            child: animatedWidget,
          );
        },
      );
    } else if (animationType == AnimationType.scaleCenterZoomOut) {
      animatedWidget = AnimatedBuilder(
        animation: _scaleAnimation!,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation!.value,
            alignment: Alignment.center,
            child: animatedWidget,
          );
        },
      );
    }

    return animatedWidget;
  }
}
