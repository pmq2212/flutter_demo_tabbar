import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:magazinedemo/controllers/tab_controller.dart';
import 'package:magazinedemo/modals/tab_page.dart';
import 'package:magazinedemo/presentations/animations/custom_animation.dart';
import 'package:magazinedemo/presentations/components/custom_scroll_animation.dart';
import 'package:magazinedemo/presentations/main_page/custom_page.dart';
import 'package:magazinedemo/presentations/main_page/sample_page.dart';

/// カスタムタブビュー
class CustomTabView extends StatefulWidget {
  const CustomTabView({Key? key}) : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: customCarouselController,
      items: List.generate(tabList.length, (index) {
        return CustomScrollAnimation(
          curve: Curves.easeInOutBack,
          durationMilliseconds: 1000,
          child: Column(
            children: [
              // サンプルタブ画面
              SamplePage(indexPage: index),
              // カスタムタブ画面
              // CustomPage(),
              // ナビゲーションバーための余白
              const SizedBox(height: 60),
            ],
          ),
        );
      }),
      options: CarouselOptions(viewportFraction: 1.0, height: double.infinity),
    );
  }
}
