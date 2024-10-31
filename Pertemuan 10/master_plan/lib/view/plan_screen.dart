import '../model/data_layer.dart';
import '../provider/plan_provider.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;
  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return Scaffold(
        appBar: AppBar(
             backgroundColor: Color.fromARGB(255, 208, 182, 212),
            title: const Text('Master Plan Najwa Azzahra')),
        body: ValueListenableBuilder<List<Plan>>(
            valueListenable: plansNotifier,
            builder: (context, plans, child) {
              Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);
              return Column(
                children: [
                  Expanded(child: buildList(currentPlan)),
                  SafeArea(child: Text(currentPlan.completenessMessage))
                ],
              );
            }),
        floatingActionButton: _buildAddTaskButton(context));
  }

  Widget buildList(Plan plan) {
    return ListView.builder(
        controller: ScrollController(),
        keyboardDismissBehavior:
            Theme.of(context).platform == TargetPlatform.iOS
                ? ScrollViewKeyboardDismissBehavior.onDrag
                : ScrollViewKeyboardDismissBehavior.manual,
        itemCount: plan.tasks.length,
        itemBuilder: (context, index) =>
            _buildTaskTile(plan.tasks[index], index, context));
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Plan currentPlan = plan;
        int planIndex =
            planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
        List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
          ..add(const Task());
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );
      },
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
            Plan currentPlan = plan;
            int planIndex = planNotifier.value
                .indexWhere((p) => p.name == currentPlan.name);
            planNotifier.value = List<Plan>.from(planNotifier.value)
              ..[planIndex] = Plan(
                name: currentPlan.name,
                tasks: List<Task>.from(currentPlan.tasks)
                  ..[index] = Task(
                    description: task.description,
                    complete: selected ?? false,
                  ),
              );
          }),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          Plan currentPlan = plan;
          int planIndex =
              planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: text,
                  complete: task.complete,
                ),
            );
        },
      ),
    );
  }
}