import 'package:flutter/material.dart';
import '../../src/shimmer.dart';

abstract class SkeletonScreenBase extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Duration period;
  final PQShimmerDirection direction;
  final int loop;
  final bool enabled;
  final Alignment begin;
  final Alignment end;

  const SkeletonScreenBase({
    Key? key,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.period = const Duration(milliseconds: 1500),
    this.direction = PQShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.begin = Alignment.topLeft,
    this.end = Alignment.centerRight,
  }) : super(key: key);
}
