//* Default
import 'package:flutter/material.dart';

//* Screens
import '../screens/exercise_screen.dart';
import './workout_screen_custom_clipper.dart';
import '../screens/workout_management_screen.dart';

//* Utils
import '../utils/utils.dart';

class WorkoutCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final int weekDay;

  const WorkoutCard(this.id, this.imageUrl, this.name, this.weekDay,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        WorkoutManagementScreen.route,
        arguments: {
          'title': 'Editando $name',
          'id': id,
        },
      ),
      child: Card(
        //* Adiciona o Círculo(Radius) em volta do "Card"
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SizedBox(
              //* Reserva 40% da largura da tela do dispositivo para o "SizedBox"
              width: mediaQuery.size.width * 0.4,
              child: ClipPath(
                clipper: WorkoutScreenCustomClipper(),
                child: Image(
                  image: NetworkImage(
                    // 'https://images.unsplash.com/photo-1552674605-db6ffd4facb5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
                    imageUrl,
                  ),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //* Tamanho mínimo para a "Column" no eixo principal
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    // 'Corrida',
                    name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    // 'Sábado',
                    Utils.getWeekDayName(weekDay)!,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          ExerciseScreen.route,
                          arguments: {
                            'workoutId': id,
                          },
                        ),
                        // BorderSide(color: Color.fromRGBO(0, 233, 100, 1)),
                        child: Text(
                          'Exercícios',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
