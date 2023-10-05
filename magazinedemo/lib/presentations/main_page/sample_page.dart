import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magazinedemo/controllers/tab_controller.dart';
import 'package:magazinedemo/modals/tab_page.dart';
import 'package:magazinedemo/modals/tab_state.dart';

List<Color> colorList = [
  Colors.redAccent,
  Colors.orangeAccent,
  Colors.yellowAccent,
  Colors.greenAccent,
  Colors.blueAccent,
  Colors.indigoAccent,
  Colors.purpleAccent,
];

/// サンプルタブ画面
/// [indexPage] : 現在選択されているタブのindex(必須)
class SamplePage extends StatelessWidget {
  const SamplePage({
    Key? key,
    required this.indexPage,
  }) : super(key: key);

  final int indexPage;

  @override
  Widget build(BuildContext context) {
    print('build ${tabList[indexPage].tabName}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: colorList[indexPage].withOpacity(0.5),
          child: SizedBox(
              height: 80,
              child: Center(
                  child: Text(
                '${tabList[indexPage].tabName}タブです。',
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
            style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
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
                  crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: colorList[indexPage]
                            .withOpacity(indexPage % 2 == 0 ? 0.8 : 1.0),
                      ),
                    ),
                    Text(
                      '$index',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '${tabList[indexPage].tabName}タブ',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
