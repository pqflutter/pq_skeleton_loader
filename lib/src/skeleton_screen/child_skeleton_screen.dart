import 'package:flutter/material.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/skeleton_screen_base.dart';
import '../shimmer.dart';

class PQChildSkeletonScreen extends SkeletonScreenBase {
  PQChildSkeletonScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned.fill(
          child: PQShimmer.fromColors(
            baseColor: baseColor.withAlpha(100),
            highlightColor: highlightColor,
            loop: loop,
            enabled: enabled,
            direction: direction,
            child: child,
            begin: begin,
            end: end,
          ),
        )
      ],
    );
  }
}
