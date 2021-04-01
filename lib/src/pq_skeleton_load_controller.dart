import 'package:flutter/material.dart';
import '../pq_skeleton_loader.dart';

typedef PQSkeletonLoad = Future<void> Function(
    PQSkeletonLoadController controller);

class PQSkeletonLoadController extends ChangeNotifier {
  PQSkeletonLoadController({
    required this.onLoad,
    PQSkeletonLoadStatus? state,
    bool firstLoad = true,
  }) : _state = state ?? PQSkeletonLoadStatus.blank {
    if (firstLoad) refreshData();
  }

  final PQSkeletonLoad onLoad;
  PQSkeletonLoadStatus _state;

  PQSkeletonLoadStatus get state => _state;

  set state(PQSkeletonLoadStatus value) {
    if (_state == value) return;

    _state = value;
    notifyListeners();
  }

  void refreshData() async {
    await this.onLoad.call(this);
  }
}
