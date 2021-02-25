import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mmth_flutter/constants/Theme.dart';
import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
        clipper: ClipPainter(),
        child: Image.asset("assets/img/mitsu_logo.png"),
        ),
      ),
    );
  }
}