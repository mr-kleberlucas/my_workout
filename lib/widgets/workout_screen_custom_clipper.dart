import 'package:flutter/cupertino.dart';

class WorkoutScreenCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);

    path.close();
    return path;

  }

  @override
  bool shouldReclip(CustomClipper clipper) {
    return false;
  }
}