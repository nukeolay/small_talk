import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/person.dart';

class PersonsScreen extends StatelessWidget {
  final List<Person> persons;
  const PersonsScreen(this.persons);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('titleContacts'.tr()),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/on-boarding-screen');
            },
            icon: Icon(
              Icons.help,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: persons.isEmpty
              ? Center(
                  child: Text(
                    'noContacts'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          tileColor: Theme.of(context).cardColor,
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: persons[index].contact),
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          leading: Icon(
                            Icons.favorite,
                            size: 50,
                            color: persons[index].color,
                          ),
                          title: Text(persons[index].contact),
                          subtitle: Text(persons[index].name),
                          trailing: Icon(Icons.copy),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
