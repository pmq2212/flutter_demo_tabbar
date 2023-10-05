import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/tab_controller.dart';
import 'package:magazinedemo/modals/tab_page.dart';
import 'package:magazinedemo/modals/tab_state.dart';

/// カスタムタブバー
class CustomTabBar extends ConsumerWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forwardListKey = UniqueKey();
    final tabNumber = ref.watch(tabControllerProvider);
    final tabNotifier = ref.watch(tabControllerProvider.notifier);

    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Expanded(
              child: Scrollable(
            axisDirection: AxisDirection.right,
            physics: const ClampingScrollPhysics(),
            viewportBuilder: (BuildContext context, ViewportOffset offset) {
              return Viewport(
                axisDirection: AxisDirection.right,
                offset: offset,
                center: forwardListKey,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final reverseIndex =
                          ((index % tabList.length) - (tabList.length - 1))
                              .abs();
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: RawChip(
                          showCheckmark: false,
                          backgroundColor: Colors.transparent,
                          selectedColor: Colors.red,
                          selected: tabNumber.tabNumber == reverseIndex,
                          shadowColor: Colors.transparent,
                          label: Text(
                            tabList
                                .firstWhere((element) =>
                                    element.tabNumber == reverseIndex)
                                .tabName,
                            style: TextStyle(
                                color: tabNumber.tabNumber == reverseIndex
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            tabNotifier.changeTab(TabState(
                                tabNumber: reverseIndex,
                                currentIndex: -index - 1,
                                pastIndex: tabNumber.currentIndex));
                          },
                        ),
                      );
                    }),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: RawChip(
                          showCheckmark: false,
                          backgroundColor: Colors.transparent,
                          selectedColor: Colors.red,
                          shadowColor: Colors.transparent,
                          selected:
                              tabNumber.tabNumber == (index % tabList.length),
                          label: Text(
                            tabList
                                .firstWhere((element) =>
                                    element.tabNumber ==
                                    (index % tabList.length))
                                .tabName,
                            style: TextStyle(
                                color: tabNumber.tabNumber ==
                                        (index % tabList.length)
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            final selectedTabNumber = index % tabList.length;
                            tabNotifier.changeTab(TabState(
                                tabNumber: selectedTabNumber,
                                currentIndex: index,
                                pastIndex: tabNumber.currentIndex));
                          },
                        ),
                      );
                    }),
                    key: forwardListKey,
                  ),
                ],
              );
            },
          )),
          Container(
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
