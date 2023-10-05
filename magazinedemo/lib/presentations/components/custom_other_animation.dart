import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/animation_controller.dart';

// アニメーションタイプ
enum AnimationType {
  none, // アニメーションなし
  scale, // サイズを変更するアニメーション
  scroll, // 縦スクロールのアニメーション
  slide, // 横スーワイプのアニメーション
}

/// カスタム可能なアニメーション
/// [child] : 共通のアニメーションwidget内に表示する小widget(必須)
/// [animationType] : アニメーションタイプ
class CustomOtherAnimation extends StatefulWidget {
  const CustomOtherAnimation({
    Key? key,
    required this.child,
    this.animationType = AnimationType.none,
    this.animationController,
  }) : super(key: key);

  final Widget child;
  final AnimationType animationType;
  final AnimationController? animationController;

  @override
  State<CustomOtherAnimation> createState() => _CustomOtherAnimationState();
}

class _CustomOtherAnimationState extends State<CustomOtherAnimation> {
  @override
  Widget build(BuildContext context) {
    switch (widget.animationType) {
      case AnimationType.scale:
        return _CustomScaleAnimation(
            animationController: widget.animationController!,
            child: widget.child);
      case AnimationType.scroll:
        return _CustomScrollAnimation(child: widget.child);
      case AnimationType.slide:
        return _CustomSlideAnimation(child: widget.child);
      case AnimationType.none:
      default:
        return widget.child;
    }
  }
}

/// widgetのサイズを変更するカスタムアニメーション
class _CustomScaleAnimation extends ConsumerStatefulWidget {
  const _CustomScaleAnimation({
    Key? key,
    required this.child,
    required this.animationController,
  }) : super(key: key);

  final Widget child;
  final AnimationController animationController;

  @override
  ConsumerState<_CustomScaleAnimation> createState() =>
      _CustomScaleAnimationState();
}

class _CustomScaleAnimationState extends ConsumerState<_CustomScaleAnimation> {
  @override
  Widget build(BuildContext context) {
    final Tween<double> tween = ref.watch(scaleAnimationControllerProvider);

    return ScaleTransition(
        scale: widget.animationController.drive(tween), child: widget.child);
  }
}

/// widgetをスクロールする際に動くカスタムアニメーション
class _CustomScrollAnimation extends ConsumerStatefulWidget {
  const _CustomScrollAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  ConsumerState<_CustomScrollAnimation> createState() => _CustomScrollAnimationState();
}

class _CustomScrollAnimationState extends ConsumerState<_CustomScrollAnimation> {

  // スクロールを始める際の動作
  onStartScroll(ScrollMetrics metrics) {
    // if you need to do something at the start
  }

  // スクロール中の動作
  onUpdateScroll(ScrollMetrics metrics) {
    // do your magic here to change the value
    final scroll = ref.watch(scrollAnimationControllerProvider);
    final scrollNotifier = ref.watch(scrollAnimationControllerProvider.notifier);
    if(scroll == 20.0) return;
    scrollNotifier.changeSpaceSize(true);
  }

  // スクロール終了後の動作
  onEndScroll(ScrollMetrics metrics) {
    // do your magic here to return the value to normal
    final scrollNotifier = ref.watch(scrollAnimationControllerProvider.notifier);
    scrollNotifier.changeSpaceSize(false);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            onStartScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollUpdateNotification) {
            onUpdateScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollEndNotification) {
            onEndScroll(scrollNotification.metrics);
          }
          return true;
        },
        child: widget.child);
  }
}

/// widgetをスライドする際に動くカスタムアニメーション

class _CustomSlideAnimation extends StatefulHookConsumerWidget {
  const _CustomSlideAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.linear,
    this.beginOffset = Offset.zero,
    this.endOffset = Offset.zero,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset beginOffset;
  final Offset endOffset;

  @override
  ConsumerState<_CustomSlideAnimation> createState() =>
      _CustomSlideAnimationState();
}

class _CustomSlideAnimationState extends ConsumerState<_CustomSlideAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> pageAnimation;
  late AnimationController pageAnimationController;

  @override
  void initState() {
    pageAnimationController =
        AnimationController(vsync: this, duration: widget.duration);
    pageAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    )
        .chain(
          CurveTween(
            curve: widget.curve,
          ),
        )
        .animate(pageAnimationController);
    super.initState();
  }

  @override
  void dispose() {
    pageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: pageAnimation, child: widget.child);
  }
}
