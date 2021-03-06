import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonItem extends StatefulWidget {
  const PersonItem({
    Key? key,
    required this.id,
    required this.contact,
    required this.name,
    required this.color,
    required this.removePerson,
  }) : super(key: key);

  final String id;
  final String contact;
  final String name;
  final Color color;
  final Function removePerson;

  @override
  State<PersonItem> createState() => _PersonItemState();
}

class _PersonItemState extends State<PersonItem> {
  @override
  Widget build(BuildContext context) {
    final phoneValidation = RegExp(r'^(?:[+0][1-9])?[0-9]{6,14}$');
    final bool _isPhoneNumber = phoneValidation.hasMatch(widget.contact);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Dismissible(
          key: ValueKey(widget.id),
          background: Container(
            color: Theme.of(context).errorColor,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 24,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.removePerson(widget.id);
          },
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            tileColor: Theme.of(context).cardColor,
            leading: Icon(
              Icons.favorite,
              size: 50,
              color: widget.color,
            ),
            title: Text(widget.contact),
            subtitle: Text(widget.name),
            trailing: _isPhoneNumber
                ? CallContactButton(phoneNumber: widget.contact)
                : CopyContactButton(widget: widget),
          ),
        ),
      ),
    );
  }
}

class CopyContactButton extends StatelessWidget {
  const CopyContactButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PersonItem widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.copy),
      onPressed: () {
        Clipboard.setData(
          ClipboardData(text: widget.contact),
        );
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Text(
            'contactCopied'.tr(),
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}

class CallContactButton extends StatelessWidget {
  const CallContactButton({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.call),
      onPressed: () {
        launch('tel:$phoneNumber');
      },
    );
  }
}
