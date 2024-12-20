import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pizza_api_najwa_azzahra/httphelper.dart';
import 'package:pizza_api_najwa_azzahra/pizza.dart';
import 'package:pizza_api_najwa_azzahra/pizza_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 185, 212),
        title: const Text('Najwa JSON'),
      ),
      body: FutureBuilder<List<Pizza>>(
        future: callPizzas(),
        builder: (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: (snapshot.data == null) ? 0 : snapshot.data!.length,
            itemBuilder: (BuildContext context, int position) {
              return Dismissible(
                key: Key(snapshot.data![position].id.toString()),
                onDismissed: (direction) {
                  setState(() {
                    HttpHelper helper = HttpHelper();
                    // Save the deleted pizza details before removing it
                    Pizza deletedPizza = snapshot.data![position];

                    // Call delete API
                    helper.deletePizza(deletedPizza.id);

                    // Remove the pizza from the list
                    snapshot.data!.removeAt(position);

                    // Log the deletion in the console
                    print(
                        "Deleted Pizza: ${deletedPizza.pizzaName} (ID: ${deletedPizza.id})");
                  });
                },
                child: ListTile(
                  title: Text(snapshot.data![position].pizzaName),
                  subtitle: Text(
                    '${snapshot.data![position].description} - € ${snapshot.data![position].price.toStringAsFixed(2)}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PizzaDetailScreen(
                          pizza: snapshot.data![position],
                          isNew: false,
                        ),
                      ),
                    );
                  },
                ),
              );
            },

            // itemCount: snapshot.data!.length,
            // itemBuilder: (BuildContext context, int position) {
            //   final Pizza currentPizza = snapshot.data![position];
            //   return ListTile(
            //     title: Text(currentPizza.pizzaName),
            //     subtitle: Text(
            //       '${currentPizza.description} - € ${currentPizza.price.toStringAsFixed(2)}',
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => PizzaDetailScreen(
            //             pizza: currentPizza,
            //             isNew: false, // Editing existing pizza
            //           ),
            //         ),
            //       );
            //     },
            //   );
            // },
          );
        },
      ),
      //floating action button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PizzaDetailScreen(
                pizza: Pizza(
                  id: 0, // Default values for a new pizza
                  pizzaName: '',
                  description: '',
                  price: 0.0,
                  imageUrl: '',
                ),
                isNew: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
