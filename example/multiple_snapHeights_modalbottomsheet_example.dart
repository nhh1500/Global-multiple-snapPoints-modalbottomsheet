import 'package:flutter/material.dart';
import 'package:global_multiple_snapheights_modalbottomsheet/multiple_snapHeights_modalbottomsheet.dart';
import 'package:global_multiple_snapheights_modalbottomsheet/src/model/snapHeight.dart';

import 'childWidget.dart';

void main() {
  configBottomSheet();
  runApp(const MyApp());
}

void configBottomSheet() {
  CustomBottomSheet.instance
    ..sensitivity = 500
    ..duration = const Duration(seconds: 2)
    ..snapHeight = [
      SnapHeight(0),
      SnapHeight(0.1, minHeight: 50, maxHeight: 50),
      SnapHeight(0.5),
      SnapHeight(1)
    ]
    ..widget = ChildWidget(color: Colors.amber)
    ..barrierDismissible = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: CustomBottomSheet.instance.init(),
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        body: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (!CustomBottomSheet.instance.isOpen) {
                  CustomBottomSheet.instance.snapToIndex(1);
                }
              },
              child: const Text('show')),
          ElevatedButton(
              onPressed: () {
                CustomBottomSheet.instance.snapToHeight(0);
              },
              child: const Text('dismiss')),
          ElevatedButton(
              onPressed: () {
                CustomBottomSheet.instance
                    .setWidget(const ChildWidget(color: Colors.green));
              },
              child: const Text('green')),
          ElevatedButton(
              onPressed: () {
                CustomBottomSheet.instance
                    .setWidget(const ChildWidget(color: Colors.yellow));
              },
              child: const Text('yellow')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(),
                    ));
              },
              child: const Text('second page'))
        ])));
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Container(
        color: Colors.pink,
      ),
    );
  }
}
