import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/action_button.dart';

class EditTextSheet extends StatefulWidget {
  final int _textNum;
  final List<String> _texts;
  final Function _updateTexts;

  EditTextSheet(
    this._textNum,
    this._texts,
    this._updateTexts,
  );

  @override
  _EditTextSheetState createState() => _EditTextSheetState();
}

class _EditTextSheetState extends State<EditTextSheet> {
  late TextEditingController _textController;
  late List<String> _texts = widget._texts;

  @override
  void initState() {
    if (widget._textNum == 0) {
      _textController = TextEditingController();
    } else {
      _textController =
          TextEditingController(text: _texts[widget._textNum - 1]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 16,
          spreadRadius: 16,
          color: Colors.black.withOpacity(0.1),
        )
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(16.0),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20.0,
            sigmaY: 20.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(16.0),
              ),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: SizedBox(width: 40.0, height: 5.0),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: TextField(
                    controller: _textController,
                    autofocus: true,
                    enableSuggestions: true,
                    autocorrect: true,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isCollapsed: true,
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.75),),
                      hintText: 'hintEnterText'.tr(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget._textNum != 0)
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              _texts.removeAt(widget._textNum - 1);
                              widget._updateTexts(_texts, false);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ActionButton(
                        'buttonSaveText'.tr(),
                        () {
                          if (widget._textNum == 0 &&
                              _textController.value.text != '') {
                            setState(() {
                              _texts.insert(0, _textController.value.text);
                              widget._updateTexts(_texts, true);
                            });
                          } else if (_textController.value.text != '') {
                            setState(() {
                              _texts[widget._textNum - 1] =
                                  _textController.value.text;
                              widget._updateTexts(_texts, false);
                            });
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

