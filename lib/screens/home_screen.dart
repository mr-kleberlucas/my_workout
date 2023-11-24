import 'package:flutter/material.dart';
//import 'package:flutter/src/material/text_button.dart';
import 'package:my_work/utils/Utils.dart';
import 'package:my_work/widgets/app_drawer.dart';
import 'package:my_work/widgets/today_workout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = '/';

  List<TextButton> _getButtonBar() {
    List<TextButton> _list = [];
    for (int i = 1; i < 8; i++) {
      _list.add(TextButton(
          onPressed: () => print('Botão $i'),
          child: Text(utils.getWeekDayName(i))));
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("My Work"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ButtonBar(
                    children: _getButtonBar(),
                  ),
                ),
                const TodayWorkout()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
