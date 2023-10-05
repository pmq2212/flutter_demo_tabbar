import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/tab_controller.dart';
import 'package:magazinedemo/modals/tab_page.dart';
import 'package:magazinedemo/modals/tab_state.dart';

/// 1秒後に経過しました！が非同期で返される。
/// 非同期が必要画面がある場合、使用
final fetchFutureProvider = FutureProvider<TabState>((ref) async {
  // if (true) {
  //   return fetchPageNumber(ref);
  // }
  await Future.delayed(const Duration(milliseconds: 1000));

  return fetchPageNumber(ref);
});

Future<TabState> fetchPageNumber(FutureProviderRef ref) async {
  final tabNumber = ref.watch(tabControllerProvider);
  return tabNumber;
}

List<int> indexList = [];

List<Color> colorList = [
  Colors.redAccent,
  Colors.orangeAccent,
  Colors.yellowAccent,
  Colors.greenAccent,
  Colors.blueAccent,
  Colors.indigoAccent,
  Colors.purpleAccent,
];

/// カスタムタブ画面
class CustomPage extends ConsumerStatefulWidget {
  const CustomPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends ConsumerState<CustomPage> {
  @override
  Widget build(BuildContext context) {
    final countFuture = ref.watch(fetchFutureProvider);
    // final tabNumber = ref.read(tabControllerProvider);

    // print('build ${tabList[tabNumber.tabNumber!].tabName}');
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Card(
    //       color: colorList[tabNumber.tabNumber!].withOpacity(0.5),
    //       child: SizedBox(
    //           height: 80,
    //           child: Center(
    //               child: Text(
    //             '${tabList[tabNumber.tabNumber!].tabName}タブです。',
    //             style: const TextStyle(color: Colors.white),
    //           ))),
    //     ),
    //     Container(
    //       height: 1,
    //       color: Colors.grey,
    //     ),
    //     const Padding(
    //       padding: EdgeInsets.all(8.0),
    //       child: Text(
    //         '新着ニュース',
    //         style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     Container(
    //       height: 1,
    //       color: Colors.grey,
    //     ),
    //     const SizedBox(
    //       height: 8,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //       child: GridView.builder(
    //           itemCount: 20,
    //           shrinkWrap: true,
    //           physics: const NeverScrollableScrollPhysics(),
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
    //           itemBuilder: (context, index) {
    //             return Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Expanded(
    //                   child: Container(
    //                     color: colorList[tabNumber.tabNumber!]
    //                         .withOpacity(index % 2 == 0 ? 0.8 : 1.0),
    //                   ),
    //                 ),
    //                 Text(
    //                   '$index',
    //                   style: const TextStyle(
    //                       fontWeight: FontWeight.bold, fontSize: 16),
    //                 ),
    //                 Text(
    //                   '${tabList[tabNumber.tabNumber!].tabName}タブ',
    //                   style: const TextStyle(color: Colors.grey, fontSize: 12),
    //                 ),
    //               ],
    //             );
    //           }),
    //     ),
    //   ],
    // );

    //　非同期用のwidget
    return countFuture.when(
      data: (data) {
        print('build ${tabList[data.tabNumber!].tabName}');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: colorList[data.tabNumber!].withOpacity(0.5),
              child: SizedBox(
                  height: 80,
                  child: Center(
                      child: Text(
                        '${tabList[data.tabNumber!].tabName}タブです。',
                        style: const TextStyle(color: Colors.white),
                      ))),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '新着ニュース',
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            color: colorList[data.tabNumber!]
                                .withOpacity(index % 2 == 0 ? 0.8 : 1.0),
                          ),
                        ),
                        Text(
                          '$index',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '${tabList[data.tabNumber!].tabName}タブ',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        );
      },
      loading: () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              color: Colors.red,
              strokeWidth: 2.0,
            ),
          ],
        ),
      ),
      error: (_, __) => const Center(child: Text("Error")),
    );
  }
}
