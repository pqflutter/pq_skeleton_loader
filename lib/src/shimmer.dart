import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// An enum defines all supported directions of PQShimmer effect
///
/// * [PQShimmerDirection.ltr] left to right direction
/// * [PQShimmerDirection.rtl] right to left direction
/// * [PQShimmerDirection.ttb] top to bottom direction
/// * [PQShimmerDirection.btt] bottom to top direction
/// * [PQShimmerDirection.cto] center to outsize direction
/// * [PQShimmerDirection.otc] outsize to center direction
///
enum PQShimmerDirection { ltr, rtl, ttb, btt, cto, otc }

///
/// A widget renders PQShimmer effect over [child] widget tree.
///
/// [child] defines an area that PQShimmer effect blends on. You can build [child]
/// from whatever [Widget] you like but there're some notices in order to get
/// exact expected effect and get better rendering performance:
///
/// * Use static [Widget] (which is an instance of [StatelessWidget]).
/// * [Widget] should be a solid color element. Every colors you set on these
/// [Widget]s will be overridden by colors of [gradient].
/// * PQShimmer effect only affects to opaque areas of [child], transparent areas
/// still stays transparent.
///
/// [period] controls the speed of PQShimmer effect. The default value is 1500
/// milliseconds.
///
/// [direction] controls the direction of PQShimmer effect. The default value
/// is [PQShimmerDirection.ltr].
///
/// [gradient] controls colors of PQShimmer effect.
///
/// [loop] the number of animation loop, set value of `0` to make animation run
/// forever.
///
/// [enabled] controls if PQShimmer effect is active. When set to false the animation
/// is paused
///
///
/// ## Pro tips:
///
/// * [child] should be made of basic and simple [Widget]s, such as [Container],
/// [Row] and [Column], to avoid side effect.
///
/// * use one [PQShimmer] to wrap list of [Widget]s instead of a list of many [PQShimmer]s
///
@immutable
class PQShimmer extends StatefulWidget {
  final Widget child;
  final Duration period;
  final PQShimmerDirection direction;
  final Gradient gradient;
  final int loop;
  final bool enabled;
  final bool reverse;

  const PQShimmer({
    Key? key,
    required this.child,
    required this.gradient,
    this.direction = PQShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.enabled = true,
    this.reverse = false,
  }) : super(key: key);

  ///
  /// A convenient constructor provides an easy and convenient way to create a
  /// [PQShimmer] which [gradient] is [LinearGradient] made up of `baseColor` and
  /// `highlightColor`.
  ///
  PQShimmer.fromColors({
    Key? key,
    required this.child,
    required Color baseColor,
    required Color highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.direction = PQShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.reverse = false,
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.centerRight,
  })  : gradient = LinearGradient(begin: begin, end: end, colors: <Color>[
          baseColor,
          baseColor,
          highlightColor,
          baseColor,
          baseColor
        ], stops: const <double>[
          0.0,
          0.35,
          0.5,
          0.65,
          1.0
        ]),
        super(key: key);

  @override
  _PQShimmerState createState() => _PQShimmerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient,
        defaultValue: null));
    properties.add(EnumProperty<PQShimmerDirection>('direction', direction));
    properties.add(
        DiagnosticsProperty<Duration>('period', period, defaultValue: null));
    properties
        .add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
  }
}

class _PQShimmerState extends State<PQShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period)
      ..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        _count++;
        if (widget.loop <= 0) {
          _controller.repeat(reverse: widget.reverse);
        } else if (_count < widget.loop) {
          _controller.forward(from: 0.0);
        }
      });
    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(PQShimmer oldWidget) {
    if (widget.enabled) {
      _controller.forward();
    } else {
      _controller.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) => _PQShimmer(
        child: child,
        direction: widget.direction,
        gradient: widget.gradient,
        percent: _controller.value,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@immutable
class _PQShimmer extends SingleChildRenderObjectWidget {
  final double percent;
  final PQShimmerDirection direction;
  final Gradient gradient;

  const _PQShimmer({
    Widget? child,
    required this.percent,
    required this.direction,
    required this.gradient,
  }) : super(child: child);

  @override
  _PQShimmerFilter createRenderObject(BuildContext context) {
    return _PQShimmerFilter(percent, direction, gradient);
  }

  @override
  void updateRenderObject(BuildContext context, _PQShimmerFilter shimmer) {
    shimmer.percent = percent;
    shimmer.gradient = gradient;
    shimmer.direction = direction;
  }
}

class _PQShimmerFilter extends RenderProxyBox {
  PQShimmerDirection _direction;
  Gradient _gradient;
  double _percent;

  _PQShimmerFilter(this._percent, this._direction, this._gradient);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  set direction(PQShimmerDirection newDirection) {
    if (newDirection == _direction) {
      return;
    }
    _direction = newDirection;
    markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final double width = child!.size.width;
      final double height = child!.size.height;
      Rect rect;
      double dx, dy;
      if (_direction == PQShimmerDirection.rtl) {
        dx = _offset(width, -width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      } else if (_direction == PQShimmerDirection.ttb) {
        dx = 0.0;
        dy = _offset(-height, height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else if (_direction == PQShimmerDirection.btt) {
        dx = 0.0;
        dy = _offset(height, -height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else if (_direction == PQShimmerDirection.ltr) {
        dx = _offset(-width, width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      } else if (_direction == PQShimmerDirection.cto) {
        double value = max(width, height);
        rect = Rect.fromCenter(
            center: Offset(width * 0.5, height * 0.5),
            width: value * _percent,
            height: value * _percent);
      } else {
        double value = max(width, height);
        rect = Rect.fromCenter(
            center: Offset(width * 0.5, height * 0.5),
            width: value * (1 - _percent),
            height: value * (1 - _percent));
      }
      layer ??= ShaderMaskLayer();
      layer!
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}
