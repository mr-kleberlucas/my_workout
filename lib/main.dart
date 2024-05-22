//* Default
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//* Screens
import './screens/home_screen.dart';
import './screens/workout_screen.dart';
import './screens/workout_management_screen.dart';
import './screens/exercise_screen.dart';
import './screens/exercise_management_screen.dart';
import './screens/login_screen.dart';

//* Providers
import './providers/workout_provider.dart';
import './providers/exercise_provider.dart';
import './providers/auth_provider.dart';

//* Helpers
import './helpers/custom_page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, WorkoutProvider>(
          create: (_) => WorkoutProvider('', ''),
          update: (_, auth, wotkout) => WorkoutProvider(auth.user, auth.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ExerciseProvider>(
          create: (_) => ExerciseProvider(''),
          update: (_, auth, exercise) => ExerciseProvider(auth.token),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Workout',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
            color: Color.fromRGBO(29, 34, 37, 0.9),
          ),
          canvasColor: Colors.transparent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: const Color.fromRGBO(0, 233, 100, 1),
              ),
          cardTheme: const CardTheme(
            color: Color.fromRGBO(60, 70, 62, 0.9),
          ),
          cardColor: const Color.fromRGBO(60, 70, 62, 0.9),
          scaffoldBackgroundColor: const Color.fromRGBO(29, 34, 37, 0.9),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleSmall: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(151, 152, 152, 1),
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: const Color.fromRGBO(0, 233, 100, 1),
            textTheme: ButtonTextTheme.primary,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color.fromRGBO(0, 233, 100, 1),
                ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Color.fromRGBO(48, 56, 62, 0.9),
            filled: true,
            border: InputBorder.none,
            labelStyle: TextStyle(
              color: Color.fromRGBO(151, 152, 152, 1),
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color.fromRGBO(0, 233, 100, 1),
            selectionHandleColor: Color.fromRGBO(0, 233, 100, 1),
          ),
          dialogBackgroundColor: const Color.fromRGBO(29, 34, 37, 1),
          dialogTheme: DialogTheme(
            titleTextStyle: TextStyle(
              // color: Colors.white,
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
        ),
        home: Consumer<AuthProvider>(
          builder: (_, provider, widget) =>
              provider.token != null ? HomeScreen() : LoginScreen(),
        ),
        routes: {
          //* Rotas das telas do app
          HomeScreen.route: (_) => HomeScreen(),
          WorkoutScreen.route: (context) => WorkoutScreen(),
          WorkoutManagementScreen.route: (_) => WorkoutManagementScreen(),
          ExerciseScreen.route: (context) => ExerciseScreen(),
          ExerciseManagementScreen.route: (_) => ExerciseManagementScreen(),
          LoginScreen.route: (context) => LoginScreen(),
        },
      ),
    );
  }
}
