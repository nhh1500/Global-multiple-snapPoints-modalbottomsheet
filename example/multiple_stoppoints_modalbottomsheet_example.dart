import 'package:flutter/material.dart';
import 'package:multiple_stoppoints_modalbottomsheet/multiple_stoppoints_modalbottomsheet.dart';

import 'childWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CustomBottomSheet(
        sensitivity: 500,
        stopPoints: [0, 50, 500, double.infinity],
        widget: ChildWidget(
          color: Colors.amber,
        ));
    return MaterialApp(
      builder: CustomBottomSheet.instance!.init(),
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
  CustomBottomSheet controller = CustomBottomSheet();

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
                if (controller.height.value == 0) {
                  controller.snapToPosition(50);
                }
              },
              child: const Text('show')),
          ElevatedButton(
              onPressed: () {
                controller.snapToPosition(0);
              },
              child: const Text('dismiss')),
          ElevatedButton(
              onPressed: () {
                controller.setWidget(const ChildWidget(color: Colors.green));
              },
              child: const Text('green')),
          ElevatedButton(
              onPressed: () {
                controller.setWidget(const ChildWidget(color: Colors.yellow));
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
