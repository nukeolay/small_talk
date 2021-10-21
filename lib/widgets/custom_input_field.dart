import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.suffix,
    required this.hintText,
    required this.textEditingController,
    required this.done,
    required this.changed,
    required this.textInputType,
    required this.myFocusNode,
  }) : super(key: key);

  final Widget? suffix;
  final String hintText;
  final TextEditingController textEditingController;
  final Function done;
  final Function changed;
  final TextInputType textInputType;
  final FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: 10.0, vertical: suffix == null ? 10.0 : 1.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        focusNode: myFocusNode,
        controller: textEditingController,
        autofocus: true,
        enableSuggestions: true,
        autocorrect: false,
        textInputAction: TextInputAction.go,
        keyboardType: textInputType,
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
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
