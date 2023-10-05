import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scaleAnimationControllerProvider = StateNotifierProvider<
    _ScaleAnimationControllerProviderNotifier, Tween<double>>((ref) {
  return _ScaleAnimationControllerProviderNotifier();
});

class _ScaleAnimationControllerProviderNotifier
    extends StateNotifier<Tween<double>> {
  _ScaleAnimationControllerProviderNotifier()
      : super(Tween<double>(begin: 1, end: 1));

  void changeScaleTween(Tween<double> tween) {
    state = tween;
  }
}

final scrollAnimationControllerProvider = StateNotifierProvider<
    _ScrollAnimationControllerProviderNotifier, double>((ref) {
  return _ScrollAnimationControllerProviderNotifier();
});

class _ScrollAnimationControllerProviderNotifier
    extends StateNotifier<double> {
  _ScrollAnimationControllerProviderNotifier()
      : super(0);

  void changeSpaceSize(bool isScrolling) {
    if (isScrolling) {
      print('you are scrolling the page');
      state = 20.0;
    } else {
      print('you stop to scroll the page');
      state = 0.0;
    }
  }
}

// // アニメーションを動くためのcontrollerを取得する。
// StateNotifierProvider pageAnimationControllerProvider(TickerProvider vsync) {
//   return StateNotifierProvider<_PageAnimationControllerNotifier,
//       AnimationController?>((ref) {
//     return _PageAnimationControllerNotifier();
//   });
// }
// // final pageAnimationControllerProvider = StateNotifierProvider<
// //     _PageAnimationControllerNotifier, AnimationController>((ref) {
// //   return _PageAnimationControllerNotifier();
// // });
//
// class _PageAnimationControllerNotifier
//     extends StateNotifier<AnimationController?> {
//   _PageAnimationControllerNotifier()
//       // : super(useAnimationController(
//       //     duration: const Duration(milliseconds: 800),
//       //   ));
//       : super(null);
// }
//
// Animatable<Offset> noneSwipeTweenAnimation = Tween<Offset>(
//   begin: Offset.zero,
//   end: Offset.zero,
// ).chain(
//   CurveTween(
//     curve: Curves.bounceOut,
//   ),
// );
// Animatable<Offset> rightSwipeTweenAnimation = Tween<Offset>(
//   begin: const Offset(-2.0, 0.0),
//   end: Offset.zero,
// ).chain(
//   CurveTween(
//     curve: Curves.bounceOut,
//   ),
// );
// Animatable<Offset> leftSwipeTweenAnimation = Tween<Offset>(
//   begin: const Offset(2.0, 0.0),
//   end: Offset.zero,
// ).chain(
//   CurveTween(
//     curve: Curves.bounceOut,
//   ),
// );
