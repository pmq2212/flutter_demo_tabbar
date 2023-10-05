import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/bottom_navigation_controller.dart';
import 'package:magazinedemo/presentations/main_page/custom_enjoy_page.dart';
import 'package:magazinedemo/presentations/main_page/custom_navigation_bar.dart';
import 'package:magazinedemo/presentations/main_page/custom_search_page.dart';
import 'package:magazinedemo/presentations/main_page/custom_tab_bar.dart';
import 'package:magazinedemo/presentations/main_page/custom_tab_view.dart';
import 'package:magazinedemo/test/test_page/test_page.dart';

List<Widget> screenList = [
  // タブビュー
  const CustomTabView(),
  // 楽しむ
  const CustomEnjoyPage(),
  // 得する
  const Center(child: Text('得する')),
  // 検索
  const CustomSearchPage(),
  // お気に入り
  const Center(child: Text('お気に入り')),
];

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationControllerProvider);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          // appbar
          appBar: AppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.grey),
                onPressed: () {},
              ),
              title: const Text('マイマガジン',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const TestPage()));
                  },
                )
              ],
              // appbarの中のタブバー
              bottom: currentIndex == 0
                  ? const PreferredSize(
                      preferredSize: Size.fromHeight(50), child: CustomTabBar())
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: Container())),
          body: Stack(
            children: [
              // 画面
              screenList[currentIndex],
              // ナビゲーションバー
              const CustomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }
}
