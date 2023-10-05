import 'dart:math' as math;

import 'package:flutter/material.dart';

/// カスタム可能なCurveアニメーション
class CustomCurve extends Curve {
  @override
  double transform(double t) {
    return 64 * math.sin( 2 * math.pi * t) ;
  }
}