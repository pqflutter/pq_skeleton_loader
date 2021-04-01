import 'package:flutter/material.dart';
import '../pq_skeleton_loader.dart';

typedef PQSkeletonBuilder = Function(
  BuildContext context,
  PQSkeletonLoadController controller,
);

/// Widget
class PQSkeletonLoaderBase extends StatefulWidget {
  final PQSkeletonBuilder builder;
  final PQSkeletonLoadController controller;

  PQSkeletonLoaderBase({
    Key? key,
    required this.builder,
    required this.controller,
  });

  @override
  _PQSkeletonLoaderBaseState createState() => _PQSkeletonLoaderBaseState();
}

class _PQSkeletonLoaderBaseState extends State<PQSkeletonLoaderBase> {
  late PQSkeletonLoadController _controller;

  PQSkeletonBuilder get builder => widget.builder;

  PQSkeletonLoadStatus get state => _controller.state;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(_handleLoadControllerTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLoadController();
  }

  @override
  void didUpdateWidget(covariant PQSkeletonLoaderBase oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateLoadController();
  }

  @override
  Widget build(BuildContext context) => builder(context, _controller);

  @override
  void dispose() {
    _controller.removeListener(_handleLoadControllerTick);
    _controller.dispose();
    super.dispose();
  }

  /// 私有方法区域
  void _updateLoadController() {
    final PQSkeletonLoadController newController = widget.controller;

    if (newController == _controller) return;

    _controller = widget.controller;
    // ignore: invalid_use_of_protected_member
    if (_controller.hasListeners) {
      _controller.removeListener(_handleLoadControllerTick);
    }

    _controller.addListener(_handleLoadControllerTick);
  }

  _handleLoadControllerTick() {
    setState(() {});
  }
}
