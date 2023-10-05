import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/modals/tab_state.dart';

final CarouselController customCarouselController = CarouselController();
const customDuration = Duration(milliseconds: 500);
const customCurves = Curves.linear;

// 選択されているタブのindex取得するため
final tabControllerProvider =
    StateNotifierProvider<_TabControllerNotifier, TabState>((ref) {
  return _TabControllerNotifier();
});

class _TabControllerNotifier extends StateNotifier<TabState> {
  _TabControllerNotifier()
      : super(TabState(tabNumber: 0, currentIndex: 0, pastIndex: 0));

  // 選択されているタブのindexを更新し、画面を移動する。
  void changeTab(TabState tabState, {Duration duration = customDuration, Curve curve = customCurves}) {
    if (state.tabNumber != tabState.tabNumber) {
      state = tabState;
      customCarouselController.animateToPage(tabState.tabNumber!,
          duration: duration, curve: curve);
    }
  }
}
