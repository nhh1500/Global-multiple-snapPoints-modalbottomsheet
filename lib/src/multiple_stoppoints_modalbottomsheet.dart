import 'package:flutter/widgets.dart';

import '../multiple_stoppoints_modalbottomsheet.dart';

class CustomBottomSheet extends ChangeNotifier {
  static CustomBottomSheet? _instance;
  static CustomBottomSheet? get instance => _instance;
  Duration duration = const Duration(microseconds: 200);
  double sensitivity = 500;
  ValueNotifier<double> height = ValueNotifier<double>(0);
  double minHeight = 0;
  double maxHeight = double.infinity;
  List<double> stopPoints = [0, double.infinity];
  Widget? widget;
  bool get isOpen => height.value != 0 ? true : false;

  factory CustomBottomSheet(
      {Widget? widget,
      List<double> stopPoints = const [0, double.infinity],
      double sensitivity = 500,
      Duration duration = const Duration(milliseconds: 200),
      double minHeight = 0,
      double maxHeight = double.infinity}) {
    if (minHeight < 0) {
      throw Exception('minHeight cannot less then zero.');
    }
    if (_instance == null) {
      _instance = CustomBottomSheet._privateConstructor();
      _instance?.widget = widget;
      _instance?.stopPoints = stopPoints;
      _instance?.sensitivity = sensitivity;
      _instance?.duration = duration;
      _instance?.minHeight = minHeight;
      _instance?.maxHeight = maxHeight;
    }
    return _instance!;
  }
  CustomBottomSheet._privateConstructor();

  ///snap to specific position
  late void Function(double toHeight) snapToPosition;

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
                child: CustomBottomSheetWidget(widget: widget!),
              )
            : const SizedBox()
      ],
    );
  }

  void setWidget(Widget widget) {
    if (_instance != null) {
      instance!.widget = widget;
    }
    notifyListeners();
  }
}
