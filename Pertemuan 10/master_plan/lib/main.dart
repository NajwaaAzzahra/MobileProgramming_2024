import 'package:flutter/material.dart';
import '../provider/plan_provider.dart';
import './view/plan_screen.dart';
import './model/data_layer.dart';
import '../view/plan_creator_screen.dart';

void main() {
  runApp(const MasterPlanApp());
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
        child: MaterialApp(
          title: "State Management App",
          theme: ThemeData(
            primarySwatch: Colors.purple,
            appBarTheme: AppBarTheme(color: Color.fromARGB(255, 208, 182, 212))
          ),
          home: const PlanCreatorScreen(),
        ),
        notifier: ValueNotifier<List<Plan>>(const []));
  }
}
