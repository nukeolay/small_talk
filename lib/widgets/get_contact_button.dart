import 'package:flutter/material.dart';
import '../widgets/not_interested_button.dart';
import '../widgets/action_button.dart';
import 'package:easy_localization/easy_localization.dart';

class GetContactButton extends StatelessWidget {
  const GetContactButton({
    required this.buttonType,
    required this.buttonTypeFunc,
  });

  final Enum buttonType;
  final Function buttonTypeFunc;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: buttonType == ButtonType.notInterested
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 500),
      firstChild: NotInterestedButton(buttonTypeFunc: buttonTypeFunc),
      secondChild: buttonType == ButtonType.saveContact
          ? ActionButton('buttonSaveContact'.tr(), buttonTypeFunc)
          : ActionButton('buttonFinish'.tr(), buttonTypeFunc),
    );
  }
}

enum ButtonType {
  notInterested,
  saveContact,
  saveName,
}
