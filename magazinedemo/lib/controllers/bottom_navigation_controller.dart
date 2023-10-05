// 選択されているタブのindex取得するため
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigationControllerProvider =
    StateNotifierProvider<_NavigationNotifier, int>((ref) {
  return _NavigationNotifier();
});

class _NavigationNotifier extends StateNotifier<int> {
  _NavigationNotifier() : super(0);

  // 選択されているナビゲーションアイテムのindexを更新する。
  void changePage(int pageNumber) {
    if (state != pageNumber) {
      state = pageNumber;
    }
  }
}
