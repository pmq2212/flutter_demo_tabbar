import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/animation_controller.dart';
import 'package:magazinedemo/presentations/components/custom_other_animation.dart';

class CustomSearchPage extends ConsumerWidget {
  const CustomSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scroll = ref.watch(scrollAnimationControllerProvider);
    return CustomOtherAnimation(
        animationType: AnimationType.scroll,
        child: ListView.builder(itemBuilder: (context, index) {
          return Center(
              child: Column(
            children: [
              const Text('検索'),
              AnimatedContainer(
                  color: Colors.red.withOpacity(0.3),
                  duration: const Duration(milliseconds: 300),
                  height: scroll)
            ],
          ));
        }));
  }
}
