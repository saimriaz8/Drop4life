import 'package:flutter/material.dart';

class RecipientOrDonorPageClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Size(:width, :height) = size;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height * 0.5);
    path.conicTo(width * 0.75, height * 0.4, 0, height * 0.7, 1);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
