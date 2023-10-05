class TabState {
  final int? tabNumber;
  final int? currentIndex;
  final int? pastIndex;

  TabState(
      {required this.tabNumber,
      required this.currentIndex,
      required this.pastIndex});

  TabState copyWith({int? tabNumber, int? currentIndex, int? pastIndex}) =>
      TabState(
        tabNumber: tabNumber ?? this.tabNumber,
        currentIndex: currentIndex ?? this.currentIndex,
        pastIndex: pastIndex ?? this.pastIndex,
      );
}
