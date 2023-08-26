import 'package:flutter/widgets.dart';

class SnapStatus {
  AnimationStatus? status;
  double height;
  double actualHeight;

  SnapStatus(this.status, this.height, this.actualHeight);
}
