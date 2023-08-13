import 'dart:ui';

import 'package:flutter/material.dart';

import '../multiple_stoppoints_modalbottomsheet.dart';

//// CustomBottomSheet Widget
class CustomBottomSheetWidget extends StatefulWidget {
  /// Option to dismiss bottomSheet if click outside of this widget
  const CustomBottomSheetWidget({super.key});

  @override
  State<CustomBottomSheetWidget> createState() =>
      _CustomBottomSheetWidgetState();
}

class _CustomBottomSheetWidgetState extends State<CustomBottomSheetWidget>
    with TickerProviderStateMixin {
  ///main controller
  CustomBottomSheet bottomSheet = CustomBottomSheet();

  ///record height before drag action
  double heightBeofreUpdate = 0;

  ///animation
  Animation<double>? _animation;

  /// animation controller
  AnimationController? controller;

  ///record the position that user tap on this widget (global)
  Offset? userTapPosGlobal;

  ///record the position that user tap on this widget (local)
  Offset? userTapPosLocal;

  ///device screen height
  double scnHeight = 0;

  @override
  void initState() {
    super.initState();
    scnHeight = window.physicalSize.longestSide / window.devicePixelRatio;
    //init method
    bottomSheet.snapToPosition = snapToPosition;
    bottomSheet.refresh = refresh;
    //set maxHeight to scnHeight
    if (bottomSheet.maxHeight == double.infinity) {
      bottomSheet.maxHeight = scnHeight;
    }
    for (int i = 0; i < bottomSheet.stopPoints.length; i++) {
      if (bottomSheet.stopPoints[i] == double.infinity) {
        bottomSheet.stopPoints[i] = scnHeight;
      }
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
        onTapOutside: onTapOutside,
        child: GestureDetector(
            onVerticalDragDown: (details) {
              stopAnimation();
              userTapPosLocal = details.localPosition;
              userTapPosGlobal = details.globalPosition;
              heightBeofreUpdate = bottomSheet.height.value;
            },
            onVerticalDragUpdate: (details) {
              var updateHeight = MediaQuery.of(context).size.height -
                  details.globalPosition.dy +
                  userTapPosLocal!.dy;
              //adjust height
              if (updateHeight < bottomSheet.minHeight) {
                updateHeight = bottomSheet.minHeight;
              }
              if (updateHeight > bottomSheet.maxHeight) {
                updateHeight = bottomSheet.maxHeight;
                if (updateHeight > scnHeight) {
                  updateHeight = scnHeight;
                }
              }
              //update height
              bottomSheet.height.value = updateHeight;
            },
            onVerticalDragEnd: (details) {
              var speed = details.velocity.pixelsPerSecond.dy.abs();
              var velocity = details.velocity.pixelsPerSecond.dy;
              bool isUp = isGoingUp(velocity);
              //If the user's sliding speed is greater than sensitivity
              if (speed > bottomSheet.sensitivity) {
                if (isUp) {
                  //up
                  var index =
                      bottomSheet.stopPoints.indexOf(heightBeofreUpdate);
                  if (index + 1 < bottomSheet.stopPoints.length) {
                    var newHeight = bottomSheet.stopPoints[index + 1];
                    if (newHeight > scnHeight) {
                      newHeight = scnHeight;
                    }
                    snapToPosition(newHeight);
                  } else {
                    snapToPosition(bottomSheet
                        .stopPoints[bottomSheet.stopPoints.length - 1]);
                  }
                } else {
                  //down
                  var index =
                      bottomSheet.stopPoints.indexOf(heightBeofreUpdate);
                  if (index - 1 > 0) {
                    snapToPosition(bottomSheet.stopPoints[index - 1]);
                  } else {
                    snapToPosition(bottomSheet.stopPoints[0]);
                  }
                }
              } else {
                //slow swipe
                snapToPosition(bottomSheet
                    .stopPoints[findClosestIndex(bottomSheet.height.value)]);
              }
            },
            //Automatically update widget when height changes
            child: ValueListenableBuilder<double>(
              valueListenable: bottomSheet.height,
              builder: (context, value, child) {
                return Container(
                  height: bottomSheet.height.value,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.pink,
                  child: bottomSheet.widget,
                );
              },
            )));
  }

  //determine whether is going up
  bool isGoingUp(double velocity) {
    if (velocity > 0) {
      return false;
    } else {
      return true;
    }
  }

  ///snap to specific position
  void snapToPosition(double toHeight) {
    //print('snap to Height ${toHeight}');
    if (controller != null) {
      controller!.dispose();
    }
    controller = AnimationController(
        vsync: this, duration: CustomBottomSheet.instance.duration);
    _animation = Tween<double>(begin: bottomSheet.height.value, end: toHeight)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut))
      ..addListener(() {
        bottomSheet.height.value = _animation!.value;
      });
    controller!.forward();
  }

  ///stop animation
  void stopAnimation() {
    if (controller != null) {
      if (controller!.isAnimating) {
        controller!.stop();
      }
    }
  }

  ///event when user tap outside
  void onTapOutside(PointerDownEvent event) {
    if (bottomSheet.barrierDismissible != null) {
      if (bottomSheet.barrierDismissible!) {
        snapToPosition(0);
      }
    }
  }

  /// find the closest index in stopPoints
  int findClosestIndex(double height) {
    int index = 0;
    double difference = double.infinity;
    for (int i = 0; i < bottomSheet.stopPoints.length; i++) {
      double n = bottomSheet.stopPoints[i] - height;
      if (n.abs() < difference) {
        difference = n.abs();
        index = i;
      }
    }
    return index;
  }
}
