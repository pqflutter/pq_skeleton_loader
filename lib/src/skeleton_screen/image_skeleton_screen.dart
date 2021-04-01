import 'package:flutter/material.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/child_skeleton_screen.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/skeleton_screen_base.dart';
import '../shimmer.dart';

class PQImageSkeletonScreen extends SkeletonScreenBase {
  PQImageSkeletonScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  PQImageSkeletonScreen.asset({
    Key? key,
    required String path,
    BoxFit fit = BoxFit.cover,
  })  : assert(path.isNotEmpty),
        image = Image.asset(path, fit: fit),
        super(key: key);

  PQImageSkeletonScreen.network({
    Key? key,
    required String url,
    BoxFit fit = BoxFit.cover,
  })  : assert(url.isNotEmpty),
        image = Image.network(url, fit: fit),
        super(key: key);

  final Widget image;

  @override
  Widget build(BuildContext context) => PQChildSkeletonScreen(child: image);
}
