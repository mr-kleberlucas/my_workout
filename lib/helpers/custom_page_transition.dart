import 'package:flutter/material.dart';

class CustomPageTransition<T> extends MaterialPageRoute<T> {
  // CustomPageTransition({required super.builder});
  CustomPageTransition({required WidgetBuilder builder})
      : super(builder: builder);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // TODO: implement buildTransitions
    // return super.buildTransitions(
    //   context,
    //   animation,
    //   secondaryAnimation,
    //   child,
    // );

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomPageTransitionBuilder<T> extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // TODO: implement buildTransitions
    // throw UnimplementedError();

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
