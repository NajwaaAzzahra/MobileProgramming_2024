import 'dart:async';
import 'package:books/geolocation.dart';
import 'package:books/navigation_dialog.dart';
import 'package:books/navigation_first.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Najwa Azzahra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const FuturePage(),
      // home: const NavigationFirst(),
      // home: LocationScreen(),
      home: FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  int appCounter = 0;
  Future readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;
    await prefs.setInt('appCounter', appCounter);
    setState(() {
      appCounter = appCounter;
    });
  }

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future Najwa'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('You have opened the app $appCounter times.'),
                  ElevatedButton(
                    // onPressed: () async {
                    //   SharedPreferences prefs =
                    //       await SharedPreferences.getInstance();
                    //   await prefs.setInt('appCounter', 0); // Reset counter
                    //   setState(() {
                    //     appCounter = 0;
                    //   });
                    // },
                    onPressed: () {
                      deletePreference();
                    },
                    child: const Text('Reset counter'),
                  ),
                ],
              ),
            ),
            // const Spacer(),
            // ElevatedButton(
            //   child: Text('GO!'),
            //   onPressed: () {
            //     handleError();
            //     // Other functionality here
            //   },
            // ),
            const Spacer(),
            Text(result),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  late Completer completer;

  Future deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  }

  Future calculate2() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      completer.complete(42);
    } catch (_) {
      completer.completeError({});
    }
  }

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/1rW-QpIAs8UC';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  void returnFG() {
    Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]).then((List<int> values) {
      int total = values.reduce((a, b) => a + b); // Menghitung total
      setState(() {
        result = total.toString();
      });
    });
  }

  Future returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened');
  }

  Future handleError() async {
    try {
      await returnError();
    } catch (error) {
      setState(() {
        result = error.toString();
      });
    } finally {
      print('Complete');
    }
  }

  // void returnFG() {
  //   FutureGroup<int> futureGroup = FutureGroup<int>();
  //   futureGroup.add(returnOneAsync());
  //   futureGroup.add(returnTwoAsync());
  //   futureGroup.add(returnThreeAsync());
  //   futureGroup.close();
  //   futureGroup.future.then((List<int> value) {
  //     int total = 0;
  //     for (var element in value) {
  //       total += element;
  //     }
  //     setState(() {
  //       result = total.toString();
  //     });
  //   });
  // }
}
