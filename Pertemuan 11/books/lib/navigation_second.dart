import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    Color color;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Najwa Navigation Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                child: const Text('Pink'),
                onPressed: () {
                  color = Colors.red.shade200;
                  Navigator.pop(context, color);
                }),
            ElevatedButton(
                child: const Text('Sage'),
                onPressed: () {
                  color = Colors.green.shade200;
                  Navigator.pop(context, color);
                }),
            ElevatedButton(
              child: const Text('Blue'),
              onPressed: () {
                color = Colors.blue.shade200;
                Navigator.pop(context, color);
              },
            )
          ],
        ),
      ),
    );
  }
}
