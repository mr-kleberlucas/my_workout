//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';

//* Widgets
import '../widgets/app_drawer.dart';
import '../widgets/workout_card.dart';

//* Screens
import './workout_management_screen.dart';

class WorkoutScreen extends StatelessWidget {
  static const route = '/workout';

  @override
  Widget build(BuildContext context) {
    //* Pegando o argumento passado por quem chamar a "workout_screen"
    var value = ModalRoute.of(context)?.settings.arguments;

    //* Imprimindo o valor
    print(value);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinos'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              WorkoutManagementScreen.route,
              arguments: {'title': 'Novo Treino'},
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Consumer<WorkoutProvider>(
            builder: (_, provider, widget) {
              print('consumer');
              // print(child);
              return ListView.builder(
                itemCount: provider.workouts.length,
                // itemCount: 6,
                itemBuilder: (_, index) {
                  return WorkoutCard(
                    provider.workouts[index].id,
                    provider.workouts[index].imageUrl,
                    provider.workouts[index].name,
                    provider.workouts[index].weekDay,
                  );
                },
              );
            },
            // child: const Text('text'),
          ),
        ],
      ),
    );
  }
}
