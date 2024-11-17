import 'package:flutter/widgets.dart';

enum TextAnimationType {
  countUp,
  countDown,
  typing,
  none,
}

class FlutterAnimatedText extends StatefulWidget {
  /// Only required for countUp and countDown
  final double? startValue;

  /// Only required for countUp and countDown
  final double? endValue;

  /// Only required for countUp and countDown
  final int precision;

  final TextAnimationType animationType;

  /// default duration Duration(seconds: 1).
  final Duration duration;

  final Curve curve;

  final TextStyle? style;

  // Only required for typing animation.
  final String? normalText;

  /// default repeatMode value: false.
  final bool repeatMode;

  const FlutterAnimatedText({
    super.key,
    this.startValue, // Make startValue nullable
    this.endValue, // Make endValue nullable
    this.animationType = TextAnimationType.none,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
    this.style,
    this.normalText,
    this.precision = 0,
    this.repeatMode = false,
  });

  @override
  FlutterAnimatedTextState createState() => FlutterAnimatedTextState();
}

class FlutterAnimatedTextState extends State<FlutterAnimatedText> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double>? _countAnimation;
  late Animation<double>? _typingAnimation;
  late Widget _animatedWidget;
  bool _wantKeepAlive = false;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    _wantKeepAlive = widget.repeatMode;

    _initializeAnimations();
    _startAnimation();
  }

  void _initializeAnimations() {
    switch (widget.animationType) {
      case TextAnimationType.countUp:
        if (widget.startValue != null && widget.endValue != null) {
          _countAnimation = Tween<double>(
            begin: widget.startValue?.toDouble(),
            end: widget.endValue?.toDouble(),
          ).animate(
            CurvedAnimation(parent: _controller, curve: widget.curve),
          );
        }
        _animatedWidget = AnimatedBuilder(
          animation: _countAnimation!,
          builder: (context, child) {
            return Text(
              _countAnimation!.value.toStringAsFixed(widget.precision), // Display as integer
              style: widget.style,
            );
          },
        );
        break;
      case TextAnimationType.countDown:
        if (widget.startValue != null && widget.endValue != null) {
          _countAnimation = Tween<double>(
            begin: widget.endValue?.toDouble(),
            end: widget.startValue?.toDouble(),
          ).animate(
            CurvedAnimation(parent: _controller, curve: widget.curve),
          );
        }
        _animatedWidget = AnimatedBuilder(
          animation: _countAnimation!,
          builder: (context, child) {
            return Text(
              _countAnimation!.value.toStringAsFixed(widget.precision), // Display as integer
              style: widget.style,
            );
          },
        );
        break;
      case TextAnimationType.typing:
        _typingAnimation = Tween<double>(
          begin: 0.0,
          end: widget.normalText?.length.toDouble(),
        ).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        _animatedWidget = AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final int length = (_typingAnimation!.value).toInt();
            return Text(
              (widget.normalText ?? '').substring(0, length),
              style: widget.style,
            );
          },
        );
        break;
      case TextAnimationType.none:
        _animatedWidget = Text(widget.normalText ?? '', style: widget.style);
        break;
    }
  }

  void _startAnimation() {
    if (widget.repeatMode) {
      _controller.repeat(reverse: false);
    } else {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant FlutterAnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animationType != oldWidget.animationType || widget.repeatMode != oldWidget.repeatMode) {
      _controller.reset();
      _initializeAnimations();
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _animatedWidget;
  }
}
