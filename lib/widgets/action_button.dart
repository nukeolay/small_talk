import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Function action;
  const ActionButton(this.text, this.action);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 50.0,
      width: (text == 'buttonStart'.tr() || text == 'buttonSaveText'.tr())
          ? null
          : MediaQuery.of(context).size.width - 20,
      child: TextButton(
        onPressed: () => action(),
        child: Text(text, style: TextStyle(fontSize: 20)),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 50.0),
          ),
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor,
          ),
          foregroundColor: MaterialStateProperty.all(
            Theme.of(context).selectedRowColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
