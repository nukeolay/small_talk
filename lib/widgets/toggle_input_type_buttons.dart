import 'package:flutter/material.dart';

class ToggleInputTypeButtons extends StatefulWidget {
  final Function toggleContactInputType;
  const ToggleInputTypeButtons(this.toggleContactInputType, {Key? key})
      : super(key: key);

  @override
  State<ToggleInputTypeButtons> createState() => _ToggleInputTypeButtonsState();
}

class _ToggleInputTypeButtonsState extends State<ToggleInputTypeButtons> {
  final List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          constraints: BoxConstraints.tight(Size(70, 10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.call,
                color: isSelected[0]
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.2),
              ),
              Icon(
                Icons.alternate_email,
                color: isSelected[1]
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.2),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            widget.toggleContactInputType();
            isSelected[0] ? isSelected[0] = false : isSelected[0] = true;
            isSelected[1] ? isSelected[1] = false : isSelected[1] = true;
          });
        });
  }
}
