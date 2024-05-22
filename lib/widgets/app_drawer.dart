//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Screens
import '../screens/home_screen.dart';
import '../screens/workout_screen.dart';

//* Providers
import '../providers/auth_provider.dart';

//* Helpers
import '../helpers/custom_page_transition.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(29, 36, 41, 0.8),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushNamed(HomeScreen.route),
            ),
            ListTile(
              leading: Icon(
                Icons.fitness_center,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: const Text('Treinos'),
              //* Passando um argumento para utilizar na "workout_screen" e chamando o widget na mesma linha
              onTap: () => Navigator.of(context).pushNamed(WorkoutScreen.route,
                  arguments: {'chave': 'valor'}),
              // onTap: () => Navigator.of(context).push(
              //   CustomPageTransition(
              //     builder: (_) => WorkoutScreen(),
              //   ),
              // ),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: const Text('Sair'),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).popUntil((route) {
                  if (route.settings.name == '/') {
                    return true;
                  }
                  return false;
                });
              },
              // onTap: () => Navigator.of(context).popUntil(
              //     (route) => route.settings.name == '/' ? true : false),
            ),
          ],
        ),
      ),
    );
  }
}
