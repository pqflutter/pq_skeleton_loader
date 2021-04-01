import 'package:flutter/material.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/skeleton_screen_base.dart';
import '../../pq_skeleton_loader.dart';
import '../shimmer.dart';

class PQListSkeletonScreen extends SkeletonScreenBase {
  PQListSkeletonScreen({
    Key? key,
    this.iconRadius = 30,
    this.lines = 3,
    this.lineWidths = const [1.0, 0.5, 0.2],
    this.lineHeight = 10,
    this.lineSpacing = 5,
    this.lineRadius = 5,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    this.crossAxisAlignment = CrossAxisAlignment.start,
  })  : assert(lines > 0),
        assert(lines == lineWidths.length),
        super(key: key);

  final double iconRadius;
  final int lines;
  final List<double> lineWidths;
  final double lineSpacing;
  final double lineHeight;
  final double lineRadius;
  final EdgeInsetsGeometry contentPadding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return PQShimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      loop: loop,
      enabled: enabled,
      direction: direction,
      begin: begin,
      end: end,
      child: ListView.builder(
        itemBuilder: (context, idx) => ListSkeletonItem(
          direction: Axis.horizontal,
          iconRadius: iconRadius,
          lines: lines,
          lineWidths: lineWidths,
          lineHeight: lineHeight,
          lineSpacing: lineSpacing,
          lineRadius: lineRadius,
          contentPadding: contentPadding,
          crossAxisAlignment: crossAxisAlignment,
        ),
        itemCount: 30,
      ),
    );
  }
}
