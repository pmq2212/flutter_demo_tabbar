import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/bottom_navigation_controller.dart';

/// 仮ナビゲーションバー
class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationControllerProvider);
    final currentIndexNotifier =
        ref.watch(navigationControllerProvider.notifier);
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.white.withOpacity(0.8),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          selectedLabelStyle:
              const TextStyle(color: Colors.black, fontSize: 12),
          unselectedLabelStyle:
              const TextStyle(color: Colors.black45, fontSize: 12),
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndexNotifier.changePage(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '楽しむ'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: '得する'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            BottomNavigationBarItem(
                icon: Icon(Icons.heart_broken), label: 'お気に入り'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
