import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/action_button.dart';
import '../widgets/carousel.dart';

class IntroduceScreen extends StatefulWidget {
  final List<String> _introduceTexts;
  final List<String> _offerTexts;
  final Function _setIntroduceTexts;
  final Function _setOfferTexts;

  IntroduceScreen(
    this._introduceTexts,
    this._offerTexts,
    this._setIntroduceTexts,
    this._setOfferTexts,
  );

  @override
  _IntroduceScreenState createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  late List<String> introduceTexts;
  late List<String> offerTexts;

  @override
  void initState() {
    introduceTexts = List<String>.from(widget._introduceTexts);
    offerTexts = List<String>.from(widget._offerTexts);
    super.initState();
  }

  PageController pageControllerIntroduce = PageController(
    viewportFraction: 0.85,
    initialPage: 1,
  );
  PageController pageControllerOffer = PageController(
    viewportFraction: 0.85,
    initialPage: 1,
  );

  void _updateIntroduceTexts(
    List<String> texts,
    bool needToMoveCarousel,
  ) {
    _updateTexts(
      texts,
      widget._setIntroduceTexts,
      pageControllerIntroduce,
      needToMoveCarousel,
    );
  }

  void _updateOfferTexts(
    List<String> texts,
    bool needToMoveCarousel,
  ) {
    _updateTexts(
      texts,
      widget._setOfferTexts,
      pageControllerOffer,
      needToMoveCarousel,
    );
  }

  void _updateTexts(
    List<String> newTexts,
    Function updateTexts,
    PageController pageController,
    bool needToMoveCarousel,
  ) {
    setState(() {
      updateTexts(newTexts);
      if (needToMoveCarousel)
        pageController.animateToPage(
          1,
          duration: Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
    });
  }

  void randomizePages() {
    setState(() {
      pageControllerIntroduce.animateToPage(
        1 + Random().nextInt(introduceTexts.length),
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
      pageControllerOffer.animateToPage(
        1 + Random().nextInt(offerTexts.length),
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 25, bottom: 15),
              alignment: Alignment.center,
              child: Text(
                'introduceYourself'.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Carousel(
                context,
                introduceTexts,
                _updateIntroduceTexts,
                pageControllerIntroduce,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25, bottom: 15),
              alignment: Alignment.center,
              child: Text(
                'writeOffer'.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Carousel(
                context,
                offerTexts,
                _updateOfferTexts,
                pageControllerOffer,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/persons-screen');
                  },
                  icon: Icon(
                    Icons.people,
                    size: 30,
                  ),
                ),
                ActionButton(
                  'buttonStart'.tr(),
                  () {
                    if (pageControllerIntroduce.page!.toInt() == 0 ||
                        pageControllerOffer.page!.toInt() == 0) {
                      if (pageControllerIntroduce.page!.toInt() == 0) {
                        setState(() {
                          pageControllerIntroduce.animateToPage(
                            1,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.bounceIn,
                          );
                        });
                      }
                      if (pageControllerOffer.page!.toInt() == 0) {
                        setState(() {
                          pageControllerOffer.animateToPage(
                            1,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.bounceIn,
                          );
                        });
                      }
                    } else {
                      Navigator.of(context)
                          .pushNamed('/get-contact-screen', arguments: <String>[
                        introduceTexts[
                            pageControllerIntroduce.page!.toInt() - 1],
                        offerTexts[pageControllerOffer.page!.toInt() - 1],
                      ]);
                    }
                  },
                ),
                IconButton(
                  onPressed: randomizePages,
                  icon: Icon(
                    Icons.autorenew,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
