import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class GlowingGradientBorder extends StatefulWidget {
  const GlowingGradientBorder({
    super.key,
    required this.child,
    required this.gradientColors,
    required this.borderRadius,
    this.animationDuration = const Duration(seconds: 2),
    this.borderSize = 0,
    this.glowSize = 5,
    this.animationProgress,
    this.stretchAlongAxis = false,
    this.stretchAxis = Axis.horizontal,
  });

  final Widget child;
  final double borderSize;
  final double glowSize;
  final List<Color> gradientColors;
  final BorderRadiusGeometry borderRadius;
  final Duration animationDuration;
  final double? animationProgress;
  final bool stretchAlongAxis;
  final Axis stretchAxis;

  @override
  State<GlowingGradientBorder> createState() => _GlowingGradientBorderState();
}

class _GlowingGradientBorderState extends State<GlowingGradientBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration)
          ..addListener(() => setState(() {}));
    _angleAnimation =
        Tween<double>(begin: 0.1, end: 2 * math.pi).animate(_controller);
    _updateAnimation();
  }

  @override
  void didUpdateWidget(GlowingGradientBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation();
  }

  void _updateAnimation() {
    final animateTo = widget.animationProgress;
    animateTo != null ? _controller.animateTo(animateTo) : _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final negativeMargin = -widget.borderSize;
    return Container(
      padding: EdgeInsets.all(widget.glowSize * 3 + widget.borderSize * 3),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: widget.borderRadius),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          _buildGradientLayer(negativeMargin),
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: widget.glowSize * 2, sigmaY: widget.glowSize * 2),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _buildGradientLayer(negativeMargin),
                BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: widget.glowSize * 0.5,
                      sigmaY: widget.glowSize * 0.5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildGradientLayer(negativeMargin),
                      _buildChild(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientLayer(double margin) {
    return Positioned.fill(
      top: margin,
      left: margin,
      right: margin,
      bottom: margin,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          gradient: SweepGradient(
            colors: [
              ...widget.gradientColors,
              ...widget.gradientColors.reversed,
            ],
            stops: List.generate(
              widget.gradientColors.length * 2,
              (index) => index / (widget.gradientColors.length * 2),
            ),
            transform: GradientRotation(_angleAnimation.value),
          ),
        ),
      ),
    );
  }

  Widget _buildChild() {
    if (!widget.stretchAlongAxis) return widget.child;

    return SizedBox(
      width: widget.stretchAxis == Axis.horizontal ? double.infinity : null,
      height: widget.stretchAxis == Axis.vertical ? double.infinity : null,
      child: widget.child,
    );
  }
}
