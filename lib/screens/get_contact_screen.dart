import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../CONSTS.dart';
import '../models/person.dart';
import '../widgets/get_contact_button.dart';

class GetContactScreen extends StatefulWidget {
  final Function addPerson;

  const GetContactScreen(this.addPerson);

  @override
  _GetContactScreenState createState() => _GetContactScreenState();
}

class _GetContactScreenState extends State<GetContactScreen> {
  late TextEditingController editingController;
  late Person newPerson;
  late String hintText;
  late Enum buttonType;
  late Function buttonTypeFunc;
  late Function changed;

  Widget contactInputWidget(
    String hintText,
    TextEditingController textEditingController,
    Function done,
    Function changed,
  ) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: textEditingController,
        autofocus: false,
        enableSuggestions: true,
        autocorrect: false,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        onSubmitted: (_) => done(),
        onChanged: (_) => changed(),
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        decoration: InputDecoration(
          fillColor: Theme.of(context).hintColor,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.all(4),
          hintStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).scaffoldBackgroundColor),
          counterStyle: TextStyle(fontSize: 20),
          hintText: hintText,
        ),
      ),
    );
  }

  @override
  void initState() {
    editingController = TextEditingController();
    buttonTypeFunc = notInterested;
    hintText = 'hintInputContact'.tr();
    buttonType = ButtonType.notInterested;
    super.initState();
  }

  void saveContact() {
    setState(() {
      newPerson = new Person(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'unknownName'.tr(),
          contact: editingController.value.text,
          color: COLORS[Random().nextInt(COLORS.length - 1)]);
      widget.addPerson(newPerson);
      hintText = 'hintInputName'.tr();
      buttonType = ButtonType.saveName;
      buttonTypeFunc = saveName;
      editingController.clear();
    });
  }

  void changedContact() {
    setState(() {
      if (buttonType != ButtonType.saveName) {
        setState(() {
          buttonType = ButtonType.saveContact;
          buttonTypeFunc = saveContact;
        });
      }
      if (editingController.value.text == '' &&
          buttonType == ButtonType.saveContact) {
        setState(() {
          buttonType = ButtonType.notInterested;
          buttonTypeFunc = notInterested;
        });
      }
    });
  }

  void notInterested() {
    Navigator.of(context).popAndPushNamed(
      '/accepted-screen',
      arguments: [
        '💔',
        Theme.of(context).primaryColor,
      ],
    );
  }

  void saveName() {
    setState(() {
      if (editingController.value.text != '') {
        newPerson.name = editingController.value.text;
        widget.addPerson(newPerson);
      }
      Navigator.of(context).popAndPushNamed(
        '/accepted-screen',
        arguments: [
          '💖',
          Colors.red,
        ],
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
                        contactInputWidget(
                          hintText,
                          editingController,
                          buttonTypeFunc,
                          changedContact,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: GetContactButton(
                            buttonType: buttonType,
                            buttonTypeFunc: buttonTypeFunc,
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
