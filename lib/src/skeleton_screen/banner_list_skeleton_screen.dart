import 'package:flutter/material.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/skeleton_screen_base.dart';
import '../shimmer.dart';

class PQBannerListSkeletonScreen extends SkeletonScreenBase {
  PQBannerListSkeletonScreen({
    Key? key,
    this.bannerHeight = 100,
    this.bannerRadius = 5,
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

  final double bannerHeight;
  final double bannerRadius;
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
        itemBuilder: (context, idx) => _listSkeletonItem(context, idx),
        itemCount: 30,
      ),
    );
  }

  _listSkeletonItem(context, index) {
    if (index == 0) {
      return Container(
        height: bannerHeight,
        margin: contentPadding,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(bannerRadius)
        ),
      );
    }
    return ListSkeletonItem(
      direction: Axis.horizontal,
      iconRadius: iconRadius,
      lines: lines,
      lineWidths: lineWidths,
      lineHeight: lineHeight,
      lineSpacing: lineSpacing,
      lineRadius: lineRadius,
      contentPadding: contentPadding,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}


class ListSkeletonItem extends StatelessWidget {

  ListSkeletonItem({
    Key? key,
    required this.direction,
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
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      child: Flex(
        direction: direction,
        children: <Widget>[
          CircleAvatar(backgroundColor: Colors.blueGrey, radius: iconRadius),
          SizedBox(width: 10),
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
