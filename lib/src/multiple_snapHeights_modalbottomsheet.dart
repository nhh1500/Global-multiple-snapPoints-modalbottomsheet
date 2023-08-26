import 'package:flutter/widgets.dart';
import 'package:multiple_stoppoints_modalbottomsheet/src/model/snapHeight.dart';
import 'package:multiple_stoppoints_modalbottomsheet/src/model/snapStatus.dart';

import '../multiple_snapHeights_modalbottomsheet.dart';

/// initialize CustomBottomSheet parameter before use
class CustomBottomSheet {
  static final CustomBottomSheet _instance =
      CustomBottomSheet._privateConstructor();
  static CustomBottomSheet get instance => _instance;

  ///animation duration
  Duration duration = const Duration(microseconds: 200);

  ///if swipe speed higher than the value of sensitivity, then it will go to the less stopPoints
  double sensitivity = 500;

  /// do not modify this value, it used by animation
  final ValueNotifier<double> _height = ValueNotifier<double>(0);

  ValueNotifier<double> get height => _height;

  ///multiple snap height for the bottomSheet
  List<SnapHeight>? snapHeight;

  ///widget that show in the bottomSheet
  Widget? widget;

  ///whether to dismiss bottomSheet if tap outside
  bool? barrierDismissible;

  /// return `true` if bottomSheet is open, otherwise return `false`
  bool get isOpen => height.value != 0 ? true : false;

  ///minHeight for this bottomSheet
  double? minHeight;

  ///maxHeight for this bottomSheet
  double? maxHeight;

  ///snap to specific height, should be between 0 and 1
  late void Function(double toHeight) snapToHeight;

  ///snap to actual height in pixel
  late void Function(double toHeight) snapToActualHeight;

  ///snap to `index` which is corresponding to `snapHeight`
  late void Function(int index) snapToIndex;

  ///refresh widget
  late void Function() refresh;

  ///dismissAction
  void Function()? onDismiss;

  /// animation status
  bool animating = false;

  factory CustomBottomSheet() => _instance;
  CustomBottomSheet._privateConstructor();

  ///set bottomSheet height
  void setHeight(double height) {
    _height.value = height;
  }

  /// call back when dragging
  Function(SnapStatus status)? onDragging;

  ///call back when drag Start
  Function(SnapStatus status)? dragStart;

  /// call back when drag end
  Function(SnapStatus status)? dragEnd;

  ///init bottomSheet
  init({Widget Function(BuildContext, Widget?)? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, _bottomWidget(child!));
      } else {
        return _bottomWidget(child!);
      }
    };
  }

  ///set bottomSheet position
  Widget _bottomWidget(Widget child) {
    return Stack(
      children: [
        child,
        widget != null
            ? Positioned(
                bottom: 0,
                child: CustomBottomSheetWidget(),
              )
            : const SizedBox()
      ],
    );
  }

  ///set widget and refresh bottomsheet
  void setWidget(Widget widget) {
    instance.widget = widget;
    refresh();
  }

  ///refresh bottomSheet
  void setState() {
    refresh();
  }
}
