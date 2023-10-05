import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinity_page_view_astro/infinity_page_view_astro.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:magazinedemo/presentations/main_page/custom_page.dart';

// PageView(defaultであるwidget)、LoopPageView(ライブラリー)、InfinityPageView(ライブラリー)
// 上記のwidgetを使用してテストした画面

final testTabControllerProvider = StateProvider<int>((ref) => 0);
final testTestTabControllerProvider = StateProvider<TestTabState>(
        (ref) => TestTabState(test: 0, current: 0, past: 0));
final testOldTabControllerProvider = StateProvider<int>((ref) => 0);

class TestTabState {
  final int? test;
  final int? current;
  final int? past;

  TestTabState({required this.test, required this.current, required this.past});

  TestTabState copyWith({int? testIndex, int? currentIndex, int? pastIndex}) =>
      TestTabState(
        test: test ?? test,
        current: currentIndex ?? current,
        past: pastIndex ?? past,
      );
}

class TestPage extends StatefulHookConsumerWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage>
    with SingleTickerProviderStateMixin {
  final PageController controller = PageController();
  final LoopPageController loopPageController = LoopPageController(
      scrollMode: LoopScrollMode.shortest,
      activationMode: LoopActivationMode.immediate);
  final infinityPageController = InfinityPageController();
  final CarouselController carouselController = CarouselController();

  Future<void> movePage(int contentIndex, int index) async {
    final countState = ref.read(testTestTabControllerProvider);
    final countStateNotifier = ref.read(testTestTabControllerProvider.notifier);
    if (countState.current != index) {
      countStateNotifier.update((state) =>
          state.copyWith(testIndex: contentIndex, currentIndex: index));
      loopPageController.animateToPage(index,
          duration: const Duration(milliseconds: 800),
          curve: Curves.bounceOut);
      // infinityPageController.animateToPage(index,
      //     duration: const Duration(milliseconds: 800),
      //     curve: Curves.bounceOut);
      // controller.animateToPage(contentIndex,
      //     duration: const Duration(milliseconds: 800), curve: Curves.bounceOut);
    }
  }

  PageController testController = PageController(initialPage: 0);
  bool isReverse = false;
  int pastIndex = 0;
  int pageIndex = 0;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   testController = PageController(initialPage: 3);
    // });
    super.initState();
  }

  void changePage(int currentIndex) {
    int index = 0;
    int backIndex = 0;
    if (currentIndex >= 0) {
      index = currentIndex % 3;
    } else {
      index = ((currentIndex % 3) - (3 - 1)).abs();
    }
    if (pastIndex >= 0) {
      backIndex = pastIndex % 3;
    } else {
      backIndex = ((pastIndex % 3) - (3 - 1)).abs();
    }
    setState(() {
      if (pastIndex == currentIndex || index == backIndex) {
        pastIndex = currentIndex;
        return;
      }
      if (pastIndex < currentIndex) {
        isReverse = false;
      } else {
        isReverse = true;
      }
    });
    testController.animateToPage(
        index,
        duration: const Duration(milliseconds: 800), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  key: const ValueKey('-1_tab'),
                  onPressed: () => movePage(3, -1),
                // onPressed:  () => changePage(-1),
                  icon: const Icon(Icons.vaccines)),
              IconButton(
                  key: const ValueKey('0_tab'),
                  // onPressed:  () => changePage(0),
                  onPressed: () => movePage(0, 0),
                  icon: const Icon(Icons.add)),
              IconButton(
                  key: const ValueKey('1_tab'),
                  // onPressed:  () => changePage(1),
                  onPressed: () => movePage(1, 1),
                  icon: const Icon(Icons.multiline_chart_sharp)),
              IconButton(
                  key: const ValueKey('2_tab'),
                  // onPressed:  () => changePage(2),
                  onPressed: () => movePage(2, 2),
                  icon: const Icon(Icons.ac_unit_rounded)),
              IconButton(
                  key: const ValueKey('3_tab'),
                  // onPressed:  () => changePage(3),
                  onPressed: () => movePage(0, 3),
                  icon: const Icon(Icons.vaccines)),
            ],
          ),
        ),
      ),
      // body: CarouselSlider(
      //   carouselController: carouselController,
      //   items: List.generate(3, (index) {
      //     print('build count $index');
      //     return const SingleChildScrollView(child: CustomPage());
      //   }),
      //   options: CarouselOptions(
      //       viewportFraction: 1.0,
      //     height: double.infinity
      //   ),
      // ),
      // body: PageView.builder(
      //   reverse: isReverse,
      //   controller: testController,
      //   itemBuilder: (BuildContext context, int index) {
      //     if (index == 0) {
      //       return Center(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: const [
      //             Text('First Page'),
      //             Icon(Icons.arrow_forward_ios),
      //           ],
      //         ),
      //       );
      //     } else if (index == 1) {
      //       return const Center(
      //         child: Text('Second Page'),
      //       );
      //     } else {
      //       return Center(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: const [
      //             Icon(Icons.arrow_back_ios_new),
      //             Text('Third Page'),
      //           ],
      //         ),
      //       );
      //     }
      //   },
      // ),
      // body: PageView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   reverse: isReverse,
      //   // reverse: (countState.past ?? 0) > (countState.current ?? 0),
      //   controller: testController,
      //   // controller: controller,
      //   children: <Widget>[
      //     Center(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           Text('First Page'),
      //           Icon(Icons.arrow_forward_ios),
      //         ],
      //       ),
      //     ),
      //     const Center(
      //       child: Text('Second Page'),
      //     ),
      //     Center(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           Icon(Icons.arrow_back_ios_new),
      //           Text('Third Page'),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: LoopPageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: loopPageController,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                  '${index}_Page',
                key: ValueKey('${index}_Page'),
              ),
            );
          },
          itemCount: 3
      ),
      // body: InfinityPageView(
      //   onPageChanged: (page) {
      //     print('the page is $page');
      //   },
      //   physics: const NeverScrollableScrollPhysics(),
      //   controller: infinityPageController,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Center(
      //       child: Text('$index Page'),
      //     );
      //   },
      //   itemCount: 3,
      // ),
    );
  }
}
