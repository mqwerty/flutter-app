import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'api.dart';
import 'models.dart';
import 'screenPersonDetails.dart';

class PersonListScreen extends StatefulWidget {
  final title = 'Characters';

  PersonListScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PersonListScreen> {
  List<Person> persons = [];

  void load() async {
    try {
      final res = await loadPersonList();
      setState(() {
        this.persons = res;
      });
    } on Exception {
      EasyLoading.showError('Ошибка загрузки');
    }
  }

  void navigateToPersonDetails(int id) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PersonDetailsScreen(id: id)));
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: persons.length == 0
          ? Center(child: Text('Please, wait...'))
          : ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: persons.length,
              itemBuilder: (context, i) => showPersonNew(persons[i]),
              separatorBuilder: (context, i) => Divider(),
            ));

  Widget showPersonNew(Person person) => ListTile(
        title: Text(
          person.name,
          style: TextStyle(fontSize: 18.0),
        ),
        subtitle: Text(
          person.status.toLowerCase(),
          style: TextStyle(
              fontSize: 14.0,
              color: person.status == 'Dead'
                  ? Colors.red
                  : person.status == 'unknown'
                      ? Colors.orange
                      : ThemeColors.primary),
        ),
        leading: CircleAvatar(
          maxRadius: 40,
          backgroundImage: NetworkImage(person.image),
        ),
        onTap: () => navigateToPersonDetails(person.id),
      );
}
