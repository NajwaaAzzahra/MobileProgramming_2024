import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String documentPath = '';
  String tempPath = '';
  late File myFile;
  String fileText='';
  int _counter = 0;

  Future<bool> writeFile() async {
  try {
    await myFile.writeAsString('Margherita, Capricciosa Napoli');
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> readFile() async {
  try {
    //read the file
    String fileContent = await myFile.readAsString();
    setState(() {
      fileText = fileContent;
    });
    return true;
  } catch (e) {
    return false;
  }
}

  Future<void> getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    setState(() {
      documentPath = docDir.path;
      tempPath = tempDir.path;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getPaths();
  // }

  @override
  void initState() {
    getPaths().then((_) {
      myFile = File('$documentPath/pizza.txt');
      writeFile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Najwa Path Provider'),
          backgroundColor: const Color.fromARGB(255, 225, 208, 196)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Doc path: $documentPath',
          ),
          Text(
            'Temp path: $tempPath',
          ),
          ElevatedButton (
            child: const Text('Read File'),
            onPressed: () => readFile(),
          ),
          Text(fileText),
        ],
      ),
    );
  }
}
