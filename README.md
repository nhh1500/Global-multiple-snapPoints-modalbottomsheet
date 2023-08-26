# Global-multiple-snapHeights-modalbottomsheet
<img src="https://media.discordapp.net/attachments/343876281793773578/1140280974253498479/Recording_2023-08-13_at_21.49.01.gif" width=200 height=429/>

## Installing
Add this yo your package's `pubspec.yaml` file:
```yaml
dependencies:
  global_multiple_snapheights_modalbottomsheet:
    git:
      url: https://github.com/nhh1500/Global-multiple-snapPoints-modalbottomsheet
```

### How to use
Frist, initialize `CustomBottomSheet` before `runApp`
```dart
CustomBottomSheet.instance
    ..sensitivity = 500
    ..duration = const Duration(seconds: 2)
    ..snapHeight = [
      SnapHeight(0),
      SnapHeight(0.1, minHeight: 50, maxHeight: 50),
      SnapHeight(0.5),
      SnapHeight(1)
    ]
    ..widget = const ChildWidget(color: Colors.amber)
    ..barrierDismissible = false;
  CustomBottomSheet.instance.dragStart = dragStart;
  CustomBottomSheet.instance.onDragging = dragging;
```
Then, initialize in your `MaterialApp` / `CupertinoApp`
```dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: CustomBottomSheet.instance!.init(),
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
```
Standard Controls:
```dart
CustomBottomSheet.instance.snapToIndex(1);
CustomBottomSheet.instance.snapToHeight(0.5);
CustomBottomSheet.instance.snapToActualHeight(500);
CustomBottomSheet.instance.setWidget(const ChildWidget(color: Colors.green));
```
