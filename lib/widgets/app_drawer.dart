import 'package:flutter/material.dart';
import 'package:my_work/screens/home_screen.dart';
import 'package:my_work/screens/workout_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(29, 36, 41, 0.8),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).accentColor,
              ),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushNamed(HomeScreen.route,),
            ),
            ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: Theme.of(context).accentColor,
              ),
              title: const Text('Treinos'),
              onTap: () =>
                  Navigator.of(context).pushNamed(WorkoutScreen.route,),
            ),
          ],
        ),
      ),
    );
  }
}
