import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'api.dart';
import 'models.dart';

const textNormal = TextStyle(fontSize: 16.0);
const textBold = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

class PersonDetailsScreen extends StatefulWidget {
  final int id;

  PersonDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsScreen> {
  final int id;
  PersonDetails? person;

  _State({required this.id}) : super();

  void load() async {
    try {
      final res = await loadPersonDetails(id);
      setState(() {
        this.person = res;
      });
    } on Exception {
      EasyLoading.showError('Ошибка загрузки');
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(person == null ? '' : person!.name),
        ),
        body: person == null
            ? Center(child: Text('Please, wait...'))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      person!.avatar,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Row(
                        children: [
                          Text('Name: ', style: textBold),
                          Text(person!.name, style: textNormal),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12, left: 16),
                      child: Row(
                        children: [
                          Text('Status: ', style: textBold),
                          Text(person!.status, style: textNormal),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12, left: 16),
                      child: Row(
                        children: [
                          Text('Gender: ', style: textBold),
                          Text(person!.gender, style: textNormal),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12, left: 16),
                      child: Row(
                        children: [
                          Text('Species: ', style: textBold),
                          Text(person!.species, style: textNormal),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12, left: 16),
                      child: Row(
                        children: [
                          Text('Origin: ', style: textBold),
                          Text(person!.originName, style: textNormal),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
}
