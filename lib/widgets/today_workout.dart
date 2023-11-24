import 'package:flutter/material.dart';

class TodayWorkout extends StatelessWidget {
  const TodayWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _query = MediaQuery.of(context);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: _query.size.width * 0.6,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 30, bottom: 20),
                        child: Text(
                          'Treino do dia',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
                        child: Text('Treino',
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
              child: Image(
                image: AssetImage(
                    'assets/images/treino.jpg'),
                width: 130,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
