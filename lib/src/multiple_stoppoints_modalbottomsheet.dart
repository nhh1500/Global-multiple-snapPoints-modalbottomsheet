import 'package:flutter/widgets.dart';

import '../multiple_stoppoints_modalbottomsheet.dart';

/// initialize CustomBottomSheet parameter before use
class CustomBottomSheet extends ChangeNotifier {
  static final CustomBottomSheet _instance =
      CustomBottomSheet._privateConstructor();
  static CustomBottomSheet get instance => _instance;

  ///animation duration
  Duration duration = const Duration(microseconds: 200);

  ///if swipe speed higher than the value of sensitivity, then it will go to the less stopPoints
  double sensitivity = 500;

  /// do not modify this value, it used by the bottomsheet widget
  ValueNotifier<double> height = ValueNotifier<double>(0);

  ///minHeight of the bottomSheet
  double minHeight = 0;

  ///maxHeight of the bottomSheet
  double maxHeight = double.infinity;

  ///multiple stopPoints for the bottomSheet
  List<double> stopPoints = [0, double.infinity];

  ///widget that show in the bottomSheet
  Widget? widget;

  ///whether to dismiss bottomSheet if tap outside
  bool? barrierDismissible;

  /// return `true` if bottomSheet is open, otherwise return `false`
  bool get isOpen => height.value != 0 ? true : false;

  factory CustomBottomSheet() => _instance;
  CustomBottomSheet._privateConstructor();

  ///snap to specific position
  late void Function(double toHeight) snapToPosition;

  ///refresh widget
  late void Function() refresh;

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
}
