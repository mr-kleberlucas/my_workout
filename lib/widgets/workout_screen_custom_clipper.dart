import 'package:flutter/material.dart';

class WorkoutScreenCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, size.height); //* Ponto Inicial
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0); //* Ponto Final

    path.close(); //* Traçando uma linha a partir do Ponto Final até o Ponto Inicial

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
