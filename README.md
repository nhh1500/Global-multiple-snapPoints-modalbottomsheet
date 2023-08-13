# multiple-stopPoints-modalbottomsheet
<img src="https://media.discordapp.net/attachments/343876281793773578/1140280974253498479/Recording_2023-08-13_at_21.49.01.gif" width=200 height=429/>

## Installing
Add this yo your package's `pubspec.yaml` file:
```yaml
dependencies:
  multiple_stoppoints_modalbottomsheet:
    git:
      url: https://github.com/nhh1500/multiple-stopPoints-modalbottomsheet
```

### How to use
Frist, initialize `CustomBottomSheet` before `runApp`
```dart
CustomBottomSheet.instance
    ..duration = Duration(milliseconds: 20)
    ..stopPoints = [0, 50, 500, double.infinity]
    ..widget = ChildWidget(color: Colors.amber)
    ..barrierDismissible = false;
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
CustomBottomSheet.instance.snapToPosition(0);
CustomBottomSheet.instance.setWidget(const ChildWidget(color: Colors.green));
```
