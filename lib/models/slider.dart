import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SlideModel {
  final String title;
  final String imagePath;
  final String instruction;

  SlideModel(
      {required this.title,
      required this.imagePath,
      required this.instruction});
}

List<SlideModel> getSlides(BuildContext context) {
  List<SlideModel> slides = [];

  SlideModel slideModel1 = new SlideModel(
    imagePath: 'onb_img1'.tr(),
    title: 'onb_title1'.tr(),
    instruction: 'onb_text1'.tr(),
  );
  slides.add(slideModel1);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel2 = new SlideModel(
    imagePath: 'onb_img2'.tr(),
    title: 'onb_title2'.tr(),
    instruction: 'onb_text2'.tr(),
  );
  slides.add(slideModel2);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel3 = new SlideModel(
    imagePath: 'onb_img3'.tr(),
    title: 'onb_title3'.tr(),
    instruction: 'onb_text3'.tr(),
  );
  slides.add(slideModel3);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  return slides;
}
