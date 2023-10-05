import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/animation_controller.dart';
import 'package:magazinedemo/presentations/components/custom_other_animation.dart';

class CustomEnjoyPage extends ConsumerStatefulWidget {
  const CustomEnjoyPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomEnjoyPage> createState() => _CustomEnjoyPageState();
}

class _CustomEnjoyPageState extends ConsumerState<CustomEnjoyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tweenNotifier = ref.watch(scaleAnimationControllerProvider.notifier);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('楽しむ'),
        const SizedBox(height: 16),
        CustomOtherAnimation(
          animationType: AnimationType.scale,
          animationController: animationController,
          child: Container(
            height: 160,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              if (animationController.isCompleted) {
                animationController.reverse();
              } else if (animationController.isAnimating) {
                animationController.reverse();
              } else {
                tweenNotifier.changeScaleTween(Tween(begin: 1, end: 0.3));
                animationController.forward();
              }
            },
            child: const Text(
              'アニメーションを動く',
              style: TextStyle(color: Colors.redAccent),
            ))
      ],
    ));
  }
}
