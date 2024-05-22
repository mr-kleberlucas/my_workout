import 'package:flutter/material.dart';

class TodayWorkout extends StatelessWidget {
  final String name;
  final String imageUrl;

  TodayWorkout(this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final _query = MediaQuery.of(context);

    return Card(
      //* Adiciona uma sombra que faz com que a percepção do "Card" esteja acima do "Background"
      elevation: 5,
      //* Adiciona o Círculo(Radius) em volta do "Card"
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            //* Reserva 60% da largura da tela do dispositivo para o "SizedBox"
            width: _query.size.width * 0.6,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 30,
                          bottom: 20,
                        ),
                        child: Text(
                          'Treino do Dia',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          bottom: 30,
                        ),
                        child: Text(
                          // 'Treino',
                          name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image(
                image: NetworkImage(
                  // 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
                  imageUrl,
                ),
                width: 130,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
