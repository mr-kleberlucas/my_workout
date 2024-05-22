//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Widgets
import './exercise_card.dart';

//* Providers
import '../providers/exercise_provider.dart';

class ExerciseList extends StatelessWidget {
  final String workoutId;

  ExerciseList(this.workoutId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ExerciseProvider>(context).get(workoutId),
      // builder: (_, snapshot) {
      builder: (_, AsyncSnapshot snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ExerciseCard(
                    snapshot.data[index].id,
                    snapshot.data[index].name,
                    snapshot.data[index].description,
                    snapshot.data[index].imageUrl,
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
