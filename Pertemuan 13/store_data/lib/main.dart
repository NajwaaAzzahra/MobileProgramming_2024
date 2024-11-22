import 'dart:convert';
import 'package:flutter/material.dart';
import './pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const myHomePage(),
    );
  }
}

class myHomePage extends StatefulWidget {
  const myHomePage({super.key});

  @override
  State<myHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<myHomePage> {
  List<Pizza> pizzas = [];
  String pizzaString = '';
  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        pizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Najwa'),
        backgroundColor: Colors.red.shade200,
      ),
      // body: Container(),
      // body: Text(pizzaString),
      body: ListView.builder(
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pizzas[index].pizzaName),
            subtitle: Text(pizzas[index].description),
          );
        },
      ),
    );
  }

  Future<List<Pizza>> readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzalist.json');
    List pizzaMapList = jsonDecode(myString);
    // setState(() {
    //   pizzaString = myString;
    // });

    List<Pizza> myPizzas = [];
    for (var pizza in pizzaMapList) {
      Pizza myPizza = Pizza.fromJson(pizza);
      myPizzas.add(myPizza);
    }
    return myPizzas;
  }
}
