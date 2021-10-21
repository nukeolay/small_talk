import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../CONSTS.dart';
import '../models/person.dart';
import '../widgets/get_contact_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/toggle_input_type_buttons.dart';

class GetContactScreen extends StatefulWidget {
  final Function addPerson;

  GetContactScreen(this.addPerson);

  @override
  _GetContactScreenState createState() => _GetContactScreenState();
}

class _GetContactScreenState extends State<GetContactScreen> {
  late TextEditingController _editingController;
  late Person _newPerson;
  late String _hintText;
  late Enum _buttonType;
  late Function _buttonTypeFunc;
  late Widget? _suffix;
  late TextInputType _textInputType;
  late FocusNode _myFocusNode;

  @override
  void dispose() {
    _editingController.dispose();
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _editingController = TextEditingController();
    _buttonTypeFunc = notInterested;
    _hintText = 'hintInputPhoneNumber'.tr();
    _buttonType = ButtonType.notInterested;
    _suffix = ToggleInputTypeButtons(toggleContactInputType);
    _textInputType = TextInputType.phone;
    _myFocusNode = FocusNode();
    super.initState();
  }

  void toggleContactInputType() async {
    _hintText == 'hintInputPhoneNumber'.tr()
        ? _hintText = 'hintInputAccountName'.tr()
        : _hintText = 'hintInputPhoneNumber'.tr();
    setState(() {
      FocusManager.instance.primaryFocus!.unfocus();
      _textInputType == TextInputType.phone
          ? _textInputType = TextInputType.text
          : _textInputType = TextInputType.phone;
    });
    await Future.delayed(Duration(milliseconds: 100), () {});
    setState(() {
      _myFocusNode.requestFocus();
    });
  }

  void saveContact() async {
    setState(() {
      _newPerson = new Person(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'unknownName'.tr(),
          contact: _editingController.value.text,
          color: COLORS[Random().nextInt(COLORS.length - 1)]);
      widget.addPerson(_newPerson);
      _hintText = 'hintInputName'.tr();
      _buttonType = ButtonType.saveName;
      _suffix = null;
      _buttonTypeFunc = saveName;
      _editingController.clear();
      if (_textInputType == TextInputType.phone) {
        FocusManager.instance.primaryFocus!.unfocus();
        _textInputType = TextInputType.text;
      }
    });
    await Future.delayed(Duration(milliseconds: 100), () {});
    setState(() {
      _myFocusNode.requestFocus();
    });
  }

  void changedContact() {
    setState(() {
      if (_buttonType != ButtonType.saveName) {
        setState(() {
          _buttonType = ButtonType.saveContact;
          _buttonTypeFunc = saveContact;
        });
      }
      if (_editingController.value.text == '' &&
          _buttonType == ButtonType.saveContact) {
        setState(() {
          _buttonType = ButtonType.notInterested;
          _buttonTypeFunc = notInterested;
        });
      }
    });
  }

  void notInterested() {
    Navigator.of(context).popAndPushNamed(
      '/accepted-screen',
      arguments: false, //💔
    );
  }

  void saveName() {
    setState(() {
      if (_editingController.value.text != '') {
        _newPerson.name = _editingController.value.text;
        widget.addPerson(_newPerson);
      }
      Navigator.of(context).popAndPushNamed(
        '/accepted-screen',
        arguments: true, //💖
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> texts =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        '${texts[0]}\n\n${texts[1]}',
                        softWrap: true,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Column(
                      children: [
                        CustomInputField(
                          suffix: _suffix,
                          hintText: _hintText,
                          textEditingController: _editingController,
                          done: _buttonTypeFunc,
                          changed: changedContact,
                          textInputType: _textInputType,
                          myFocusNode: _myFocusNode,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: GetContactButton(
                            buttonType: _buttonType,
                            buttonTypeFunc: _buttonTypeFunc,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
