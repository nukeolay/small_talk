import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class NotInterestedButton extends StatelessWidget {
  const NotInterestedButton({
    required this.buttonTypeFunc,
  });

  final Function buttonTypeFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 50.0,
      width: MediaQuery.of(context).size.width - 20,
      child: TextButton(
        onPressed: () => buttonTypeFunc(),
        child: Text(
          'buttonNotInterested'.tr(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 50.0),
          ),
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).scaffoldBackgroundColor,
          ),
          foregroundColor: MaterialStateProperty.all(
            Theme.of(context).hintColor,
          ),
        ),
      ),
    );
  }
}