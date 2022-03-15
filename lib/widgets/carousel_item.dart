import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/edit_text_sheet.dart';

class CarouselItem extends StatelessWidget {
  final BuildContext _context;
  final int _textNum;
  final List<String> _texts;
  final Function _updateTexts;

  CarouselItem(
    this._context,
    this._textNum,
    this._texts,
    this._updateTexts,
  );

  void showCustomBottomModalSheet(
    int _textNum,
    List<String> _texts,
    Function _updateTexts,
  ) {
    showModalBottomSheet(
      context: _context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      isScrollControlled: true,
      builder: (_) {
        return EditTextSheet(_textNum, _texts, _updateTexts);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () => showCustomBottomModalSheet(
          _textNum,
          _texts,
          _updateTexts,
        ),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _textNum == 0
                ? Theme.of(context).primaryColor.withOpacity(0.3)
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Center(
            child: Text(
                _textNum == 0 ? 'addNewIntroduce'.tr() : _texts[_textNum - 1],
                textAlign: _textNum == 0 ? TextAlign.center : TextAlign.start,
                style: TextStyle(fontSize: 30),
                softWrap: true,
                overflow: TextOverflow.fade),
          ),
        ),
      ),
    );
  }
}
