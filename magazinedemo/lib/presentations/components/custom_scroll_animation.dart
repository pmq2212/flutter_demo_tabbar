import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// カスタムスクロールアニメーション
/// [child] : 共通のスクロールwidget内に表示する小widget(必須)
/// [curve] : アニメーションの動き
/// [durationMilliseconds] : アニメーションの速度
/// [physics] : 画面をスクロールする時の動き
class CustomScrollAnimation extends ConsumerStatefulWidget {
  const CustomScrollAnimation({
    Key? key,
    required this.child,
    this.curve = Curves.linear,
    this.durationMilliseconds = 500,
    this.physics = const BouncingScrollPhysics(),
  }) : super(key: key);

  final Widget child;
  final Curve curve;
  final int durationMilliseconds;
  final ScrollPhysics physics;

  @override
  ConsumerState<CustomScrollAnimation> createState() =>
      _CustomScrollAnimationState();
}

class _CustomScrollAnimationState extends ConsumerState<CustomScrollAnimation> {
  final ScrollController scrollController = ScrollController();

  // 左フリックすると、最上部に移動する。
  void swipeToLeft() {
    final offset = scrollController.offset;
    if (offset > 0) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: widget.durationMilliseconds),
        curve: widget.curve,
      );
    }
  }

  // 右フリックすると、最下部に移動する。
  void swipeToRight() {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final offset = scrollController.offset;
    if (offset < maxScrollExtent) {
      scrollController.animateTo(
        maxScrollExtent,
        duration: Duration(milliseconds: widget.durationMilliseconds),
        curve: widget.curve,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails drag) {
        if (drag.primaryVelocity == null) return;
        if (drag.primaryVelocity! < 0) {
          swipeToLeft();
        } else {
          swipeToRight();
        }
      },
      child: SingleChildScrollView(
          controller: scrollController,
          physics: widget.physics,
          child: widget.child),
    );
  }
}
