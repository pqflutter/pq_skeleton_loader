import 'package:flutter/material.dart';

import '../shimmer.dart';

class PQCommonSkeletonScreen extends StatelessWidget {
  PQCommonSkeletonScreen({
    Key? key,
    required this.child,
    required this.gradient,
    this.period = const Duration(milliseconds: 1500),
    this.direction = PQShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.reverse = false,
  }): super(key: key);

  final Widget child;
  final Gradient gradient;
  final Duration period;
  final PQShimmerDirection direction;
  final int loop;
  final bool enabled;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned.fill(
          child: PQShimmer(
            child: child,
            gradient: gradient,
            period: period,
            direction: direction,
            loop: loop,
            enabled: enabled,
            reverse: reverse,
          ),
        )
      ],
    );
  }
}
