//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Widgets
import '../widgets/exercise_list.dart';

//* Screens
import './exercise_management_screen.dart';

class ExerciseScreen extends StatelessWidget {
  static const String route = '/exercise';

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercícios Cadastrados'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              ExerciseManagementScreen.route,
              arguments: arguments,
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ExerciseList(arguments['workoutId']),
          // Padding(
          //   padding: const EdgeInsets.only(top: 80),
          //   child: ExerciseCard(),
          // ),
        ],
      ),
    );
  }
}
