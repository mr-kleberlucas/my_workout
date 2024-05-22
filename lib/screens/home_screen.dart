//* Default
import 'package:flutter/material.dart';
import 'package:my_workout/widgets/exercise_list.dart';
import 'package:provider/provider.dart';

//* Widgets
import '../widgets/app_drawer.dart';
import '../widgets/today_workout.dart';

//* Models
import '../models/workout.dart';

//* Utils
import '../utils/utils.dart';

//* Providers
import '../providers/workout_provider.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _weekDay = DateTime.now().weekday;

  //* Função que retorna uma lista de botões
  List<TextButton> _getButtonBar() {
    List<TextButton> _list = [];
    for (int i = 1; i < 8; i++) {
      _list.add(
        TextButton(
          onPressed: () {
            setState(() {
              _weekDay = i;
            });
          },
          //* Cor do botão
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              _weekDay == i
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
            ),
            //* Borda do botão
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  50,
                ),
                side: BorderSide(
                  style: BorderStyle.solid,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          //* Texto do botão
          child: Text(
            Utils.getWeekDayName(i)!.substring(0, 3),
            style: TextStyle(
              color: _weekDay == i
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      );
    }
    return _list;
  }

  Widget _getTodayWorkout(List<Workout> workouts) {
    final index = workouts.indexWhere((element) => element.weekDay == _weekDay);
    if (index != -1) {
      return TodayWorkout(workouts[index].name, workouts[index].imageUrl);
    } else {
      return const Center(
        child: Text(
          'Nenhum treinamento encontrado para o dia selecionado.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Widget _getExercisesList(List<Workout> workouts) {
    final index = workouts.indexWhere((element) => element.weekDay == _weekDay);
    if (index != -1) {
      return Expanded(
        child: ExerciseList(workouts[index].id),
      );
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //* Coloca todo o "Body" embaixo da "Appbar"
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg3.jpg'),
                fit: BoxFit.cover, //* Preenchendo o "Background" com a imagem
              ),
            ),
          ),
          FutureBuilder(
            future: Provider.of<WorkoutProvider>(context, listen: false).get(),
            // builder: (_, snapshot) {
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  return Center(
                    // child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 80),
                        Text(
                          '${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    // ),
                  );
                } else {
                  return Padding(
                    //* Margem da screen
                    padding: const EdgeInsets.only(top: 80),
                    child: Consumer<WorkoutProvider>(
                      builder: (_, provider, widget) {
                        return Column(
                          children: [
                            widget!,
                            // TodayWorkout(),
                            _getTodayWorkout(provider.workouts),
                            _getExercisesList(provider.workouts),
                          ],
                        );
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ButtonBar(
                          children: _getButtonBar(),
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
