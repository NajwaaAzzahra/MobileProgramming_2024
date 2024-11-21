import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Najwa Azzahra Stream',
      theme: ThemeData(
        primaryColor: Colors.red.shade200,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  late StreamTransformer<int, int> transformer;
  late StreamSubscription subscription;
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  int lastNumber = 0;
  late StreamController<int> numberStreamController;
  late NumberStream numberStream;

  void changeColor() {
    colorStream.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  void stopStream() {
    numberStreamController.close();
  }

  @override
  void initState() {
    // // Inisialisasi transformer
    // transformer = StreamTransformer<int, int>.fromHandlers(
    //   handleData: (value, sink) {
    //     sink.add(value * 10);
    //   },
    //   handleError: (error, trace, sink) {
    //     sink.add(-1);
    //   },
    //   handleDone: (sink) {
    //     sink.close();
    //   },
    // );

    numberStream = NumberStream();
    numberStreamController = numberStream.controller;

    Stream stream = numberStreamController.stream;
    subscription = stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });

    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });

    subscription.onDone(() {
      print("OnDone was called");
    });

    // Stream stream = numberStreamController.stream.transform(transformer);
    // stream.listen(
    //   (event) {
    //     setState(() {
    //       lastNumber = event;
    //     });
    //   },
    //   onError: (error) {
    //     setState(() {
    //       lastNumber = -1;
    //     });
    //   },
    // );
    super.initState();
  }

  @override
  void dispose() {
    numberStreamController.close();
    super.dispose();
    subscription.cancel();
  }

  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Najwa Stream'),
        backgroundColor: const Color.fromARGB(255, 158, 174, 202),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              lastNumber.toString(),
              style: const TextStyle(fontSize: 32),
            ),
            ElevatedButton(
              onPressed: () => addRandomNumber(), // Add random number to stream
              child: const Text("Add Random Number"),
            ),
            ElevatedButton(
              onPressed: () => stopStream(), // Stop the subscription
              child: const Text("Stop Subscription"),
            ),
          ],
        ),
      ),
    );
  }
}
