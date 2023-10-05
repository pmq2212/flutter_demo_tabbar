class TabPage {
  final int tabNumber;
  final String tabName;
  final bool tabVisible;

  TabPage(
      {required this.tabNumber,
      required this.tabName,
      required this.tabVisible});
}

final tabList = [
  TabPage(tabNumber: 0, tabName: 'トップ', tabVisible: true),
  TabPage(tabNumber: 1, tabName: 'ニュース', tabVisible: true),
  TabPage(tabNumber: 2, tabName: 'スポーツ', tabVisible: true),
  TabPage(tabNumber: 3, tabName: '映画', tabVisible: true),
  TabPage(tabNumber: 4, tabName: '国内', tabVisible: true),
  TabPage(tabNumber: 5, tabName: '国外', tabVisible: true),
  TabPage(tabNumber: 6, tabName: '健康', tabVisible: true),
];
