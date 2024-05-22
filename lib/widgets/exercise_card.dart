//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Providers
import '../providers/exercise_provider.dart';

class ExerciseCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  const ExerciseCard(this.id, this.name, this.description, this.imageUrl,
      {super.key});

  void _delete(BuildContext context) async {
    await Provider.of<ExerciseProvider>(context, listen: false).delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          // '60 min de corrida',
          name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          // 'Manter velocidade constante de corrida por 60 min',
          description,
          style:
              TextStyle(color: Theme.of(context).textTheme.titleSmall!.color),
        ),
        leading: FadeInImage(
          placeholder: const AssetImage('assets/images/halter.png'),
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          image: NetworkImage(
            // 'https://img.icons8.com/bubbles/2x/timer.png',
            imageUrl,
          ),
        ),
        trailing: IconButton(
          onPressed: () => _delete(context),
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}
