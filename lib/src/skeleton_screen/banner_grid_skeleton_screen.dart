import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/skeleton_screen_base.dart';

import '../../pq_skeleton_loader.dart';

class PQBannerGridSkeletonScreen extends SkeletonScreenBase {
  PQBannerGridSkeletonScreen({
    Key? key,
    this.bannerHeight = 100,
    this.bannerRadius = 5,
    this.iconRadius = 8,
    this.lines = 3,
    this.lineWidths = const [1.0, 0.5, 0.2],
    this.lineHeight = 10,
    this.lineSpacing = 5,
    this.lineRadius = 5,
    this.contentPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.crossAxisCount = 3,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  })  : assert(lines > 0),
        assert(lines == lineWidths.length),
        super(key: key);


  final double bannerHeight;
  final double bannerRadius;
  final double iconRadius;
  final int lines;
  final List<double> lineWidths;
  final double lineRadius;
  final double lineSpacing;
  final double lineHeight;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int crossAxisCount;
  final EdgeInsetsGeometry contentPadding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width -
        max(0, crossAxisCount - 1) * crossAxisSpacing) /
        crossAxisCount;
    final double height = width +
        (lines * lineHeight) +
        (max(lines - 1, 0) * lineSpacing) +
        10 -
        contentPadding.vertical * 0.5;
    final double childAspectRatio = width / height;
    final child = GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, idx) => GridSkeletonItem(
        width: width,
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
    );

    return PQShimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      loop: loop,
      enabled: enabled,
      direction: direction,
      child: Column(
        children: [
          Container(
            margin: contentPadding,
            height: bannerHeight,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(bannerRadius)
            ),
          ),
          Expanded(child: child),
        ],
      ),
      begin: begin,
      end: end,
    );
  }

}