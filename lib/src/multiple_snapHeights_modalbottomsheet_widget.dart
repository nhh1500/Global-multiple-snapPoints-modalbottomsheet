import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:global_multiple_snapheights_modalbottomsheet/src/model/snapStatus.dart';

import '../multiple_snapHeights_modalbottomsheet.dart';

//// CustomBottomSheet Widget
class SnapHeightBottomSheetWidget extends StatefulWidget {
  /// Option to dismiss bottomSheet if click outside of this widget
  const SnapHeightBottomSheetWidget({super.key});

  @override
  State<SnapHeightBottomSheetWidget> createState() =>
      _SnapHeightBottomSheetWidgetState();
}

class _SnapHeightBottomSheetWidgetState
    extends State<SnapHeightBottomSheetWidget> with TickerProviderStateMixin {
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

  ///actual snapHeight calculate in pixel
  List<double> actualSnapHeight = [];

  SnapStatus get currentSnapStatus => SnapStatus(
      _animation?.status,
      CustomBottomSheet.instance.height.value /
          MediaQuery.of(context).size.height,
      CustomBottomSheet.instance.height.value);

  @override
  void initState() {
    super.initState();
    scnHeight =
        PlatformDispatcher.instance.views.first.physicalSize.longestSide /
            PlatformDispatcher.instance.views.first.devicePixelRatio;
    //init method
    bottomSheet.snapToHeight = snapToHeight;
    bottomSheet.snapToActualHeight = snapToActualHeight;
    bottomSheet.snapToIndex = snapToIndex;
    bottomSheet.refresh = refresh;
    WidgetsBinding.instance.addPostFrameCallback((_) => calculateSnapHeight());
  }

  void calculateSnapHeight() {
    List<double> tempSnapHeight = [];
    if (CustomBottomSheet.instance.snapHeight != null) {
      for (var snapHeight in CustomBottomSheet.instance.snapHeight!) {
        var tempHeight = MediaQuery.of(context).size.height * snapHeight.height;
        if (snapHeight.minHeight != null) {
          if (tempHeight < snapHeight.minHeight!) {
            tempHeight = snapHeight.minHeight!;
          }
        }
        if (snapHeight.maxHeight != null) {
          if (tempHeight > snapHeight.maxHeight!) {
            tempHeight = snapHeight.maxHeight!;
          }
        }
        tempSnapHeight.add(tempHeight);
      }
    }
    actualSnapHeight = tempSnapHeight;
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
              if (CustomBottomSheet.instance.dragStart != null) {
                CustomBottomSheet.instance.dragStart!(currentSnapStatus);
              }
            },
            onVerticalDragUpdate: (details) {
              var updateHeight = MediaQuery.of(context).size.height -
                  details.globalPosition.dy +
                  userTapPosLocal!.dy;
              //update height
              bottomSheet.height.value = preventOutOfScn(updateHeight);
              if (CustomBottomSheet.instance.onDragging != null) {
                CustomBottomSheet.instance.onDragging!(currentSnapStatus);
              }
            },
            onVerticalDragEnd: (details) {
              var speed = details.velocity.pixelsPerSecond.dy.abs();
              var velocity = details.velocity.pixelsPerSecond.dy;
              bool isUp = isGoingUp(velocity);
              //If the user's sliding speed is greater than sensitivity
              if (speed > bottomSheet.sensitivity) {
                var index = actualSnapHeight.indexOf(heightBeofreUpdate);
                if (isUp) {
                  //up
                  snapToIndex(index + 1);
                } else {
                  //down
                  snapToIndex(index - 1);
                }
              } else {
                //slow swipe
                snapToIndex(findClosestIndex(bottomSheet.height.value));
              }
              if (CustomBottomSheet.instance.dragEnd != null) {
                CustomBottomSheet.instance.dragEnd!(currentSnapStatus);
              }
            },
            //Automatically update widget when height changes
            child: ValueListenableBuilder<double>(
              valueListenable: bottomSheet.height,
              builder: (context, value, child) {
                return Container(
                  height: bottomSheet.height.value,
                  width: MediaQuery.of(context).size.width,
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

  ///snap to index
  void snapToIndex(int index) {
    if (index < 0) {
      index = 0;
    }
    if (index > actualSnapHeight.length - 1) {
      index = actualSnapHeight.length - 1;
    }
    snapTo(actualSnapHeight[index]);
  }

  ///snap to actual height
  void snapToActualHeight(double toHeight) {
    snapTo(toHeight);
  }

  ///snap to specific height between 0 and 1
  void snapToHeight(double toHeight) {
    snapTo(MediaQuery.of(context).size.height * toHeight);
  }

  ///base method to snapToHeight
  void snapTo(double toHeight) {
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
        if (CustomBottomSheet.instance.onDragging != null) {
          CustomBottomSheet.instance.onDragging!(currentSnapStatus);
        }
      });
    _animation?.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        CustomBottomSheet.instance.animating = false;
        if (CustomBottomSheet.instance.dragEnd != null) {
          CustomBottomSheet.instance.dragEnd!(currentSnapStatus);
        }
      } else {
        CustomBottomSheet.instance.animating = true;
      }
    });
    controller!.forward();
  }

  ///stop animation
  void stopAnimation() {
    if (controller != null) {
      if (controller!.isAnimating) {
        controller!.stop();
        CustomBottomSheet.instance.animating = false;
      }
    }
  }

  ///event when user tap outside
  void onTapOutside(PointerDownEvent event) {
    if (bottomSheet.barrierDismissible != null) {
      if (bottomSheet.barrierDismissible!) {
        snapTo(0);
      }
    }
  }

  /// find the closest index in stopPoints
  int findClosestIndex(double height) {
    int index = 0;
    double difference = double.infinity;
    for (int i = 0; i < actualSnapHeight.length; i++) {
      double n = actualSnapHeight[i] - height;
      if (n.abs() < difference) {
        difference = n.abs();
        index = i;
      }
    }
    return index;
  }

  ///adjust height when finish draggging
  double adjustHeight(double height) {
    int index = findClosestIndex(height);
    return actualSnapHeight[index];
  }

  ///prevent drag out of screen or exceed min/maxHeight define in customBottomSheet
  double preventOutOfScn(double height) {
    double retValue = height;
    if (CustomBottomSheet.instance.maxHeight != null) {
      if (retValue > CustomBottomSheet.instance.maxHeight!) {
        retValue = CustomBottomSheet.instance.maxHeight!;
      }
    }
    if (retValue > MediaQuery.of(context).size.height) {
      retValue = MediaQuery.of(context).size.height;
    }
    if (CustomBottomSheet.instance.minHeight != null) {
      if (retValue < CustomBottomSheet.instance.minHeight!) {
        retValue = CustomBottomSheet.instance.minHeight!;
      }
    }
    if (retValue < 0) {
      retValue = 0;
    }
    return retValue;
  }
}
