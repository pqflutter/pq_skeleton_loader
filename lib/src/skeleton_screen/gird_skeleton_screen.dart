import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/skeleton_screen_base.dart';
import '../shimmer.dart';

class PQGridSkeletonScreen extends SkeletonScreenBase {
  PQGridSkeletonScreen({
    Key? key,
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
      child: child,
      begin: begin,
      end: end,
    );
  }

}

class GridSkeletonItem extends StatelessWidget {

  GridSkeletonItem({
    Key? key,
    required this.width,
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
  final double width;
  final int lines;
  final List<double> lineWidths;
  final double lineSpacing;
  final double lineHeight;
  final double lineRadius;
  final EdgeInsetsGeometry contentPadding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            height: width - contentPadding.horizontal,
            width: width,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(iconRadius),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                crossAxisAlignment: crossAxisAlignment,
                children: _children(constraints),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构造横线
  Widget _lineItem(double width) {
    return Container(
      width: width,
      height: lineHeight,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(lineRadius),
      ),
    );
  }

  /// 根据参数创建横线
  List<Widget> _children(BoxConstraints constraints) {
    List<Widget> children = [];
    for (int index = 0; index < lines; index++) {
      children.add(_lineItem(lineWidths[index] * constraints.maxWidth));
      children.add(SizedBox(height: lineSpacing));
    }
    children.removeLast();
    return children;
  }
}

