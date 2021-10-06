import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/person_item.dart';
import '../models/person.dart';

class PersonsScreen extends StatelessWidget {
  final List<Person> persons;
  final Function removePerson;
  const PersonsScreen(this.persons, this.removePerson);

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
                      return PersonItem(
                        id: persons[index].id,
                        contact: persons[index].contact,
                        name: persons[index].name,
                        color: persons[index].color,
                        removePerson: removePerson,
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
