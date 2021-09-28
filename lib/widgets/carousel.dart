import 'package:flutter/material.dart';
import '../widgets/carousel_item.dart';

class Carousel extends StatelessWidget {
  final BuildContext ctx;
  final List<String> carouselTexts;
  final Function updateTexts;
  final PageController pageController;

  Carousel(
    this.ctx,
    this.carouselTexts,
    this.updateTexts,
    this.pageController,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.transparent,
          ),
        ),
        child: PageView.builder(
          controller: pageController,
          itemCount: carouselTexts.length + 1,
          itemBuilder: (BuildContext context, int itemIndex) {
            return CarouselItem(
              context,
              itemIndex,
              carouselTexts,
              updateTexts,
            );
          },
        ),
      ),
    );
  }
}
