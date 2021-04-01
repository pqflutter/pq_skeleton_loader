library pq_skeleton_loader;

/// 导出的资源文件路径
export './src/shimmer.dart';
export './src/state.dart';
export './src/pq_skeleton_loader_base.dart';
export './src/pq_skeleton_load_controller.dart';
export 'src/skeleton_screen/gird_skeleton_screen.dart';
export 'src/skeleton_screen/image_skeleton_screen.dart';
export 'src/skeleton_screen/list_skeleton_screen.dart';
export 'src/skeleton_screen/child_skeleton_screen.dart';
export 'src/skeleton_screen/common_skeleton_screen.dart';
export 'src/skeleton_screen/banner_list_skeleton_screen.dart';
export 'src/skeleton_screen/banner_grid_skeleton_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pq_skeleton_loader/src/shimmer.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/common_skeleton_screen.dart';
import 'package:pq_skeleton_loader/src/skeleton_screen/list_skeleton_screen.dart';
import 'src/pq_skeleton_load_controller.dart';
import 'src/pq_skeleton_loader_base.dart';
import 'src/state.dart';

typedef OnSuccessBuilder = Widget Function(BuildContext context, PQSkeletonLoadController controller);

class PQSkeletonLoader extends StatelessWidget {
  PQSkeletonLoader({
    Key? key,
    this.blank,
    Widget? loading,
    this.failed,
    this.noNetwork,
    this.emptyData,
    this.custom,
    required this.onSuccess,
    required this.controller,
  })   : loading = loading ?? PQListSkeletonScreen(),
        super(key: key);

  final Widget? blank;
  final Widget loading;
  final OnSuccessBuilder onSuccess;
  final Widget? failed;
  final Widget? noNetwork;
  final Widget? emptyData;
  final Widget? custom;
  final PQSkeletonLoadController controller;

  @override
  Widget build(BuildContext context) {
    return PQSkeletonLoaderBase(
      builder: (context, controller) {
        switch (controller.state) {
          case PQSkeletonLoadStatus.blank:
            return blank ?? SizedBox.shrink();
          case PQSkeletonLoadStatus.loading:
            return loading;
          case PQSkeletonLoadStatus.success:
            return onSuccess(context, controller);
          case PQSkeletonLoadStatus.failed:
            return failed ?? SizedBox.shrink();
          case PQSkeletonLoadStatus.noNetwork:
            return noNetwork ?? SizedBox.shrink();
          case PQSkeletonLoadStatus.emptyData:
            return emptyData ?? SizedBox.shrink();
          case PQSkeletonLoadStatus.custom:
            return custom ?? SizedBox.shrink();
        }
      },
      controller: controller,
    );
  }
}
