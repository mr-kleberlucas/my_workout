import 'package:flutter/material.dart';
import 'package:my_work/screens/workout_management_screen.dart';
import 'package:my_work/widgets/app_drawer.dart';
import 'package:my_work/widgets/workout_screen_custom_clipper.dart';
import '../widgets/workout_screen_custom_clipper.dart';
import '../widgets/app_drawer.dart';
import './workout_management_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  static const route = '/workut';

  @override
  Widget build(BuildContext context) {
    var value = ModalRoute.of(context)!.settings.arguments;

    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treinos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(
                WorkoutManagementScreen.route,
                arguments: {'title': 'Novo Treino'}),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: mediaQuery.size.width * 0.4,
                    child: ClipPath(
                      clipper: WorkoutScreenCustomClipper(),
                      child: const Image(
                        image: AssetImage(
                          'assets/images/treino2.jpg',
                        ),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Corrida',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Sábado',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              onPressed: () => print('click exercícios'),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 223, 100, 1),
                              ),
                              child: Text('Exercícios'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
