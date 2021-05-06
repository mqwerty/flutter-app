import 'package:flutter/material.dart';

import 'api.dart';
import 'models.dart';
import 'theme.dart';

const textNormal = TextStyle(fontSize: 16.0);
const textBold = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

class PersonDetailsScreen extends StatefulWidget {
  final String id;

  PersonDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsScreen> {
  final String id;
  PersonDetails? person;
  bool loading = true;

  _State({required this.id}) : super();

  void load() async {
    setState(() {
      this.loading = true;
    });
    try {
      final res = await loadPersonDetails(id);
      setState(() {
        this.person = res;
        this.loading = false;
      });
    } on Exception {
      // new Future.delayed(Duration.zero, () {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content: Text('Fail to load data'),
      //         backgroundColor: Colors.red[900]),
      //   );
      // });
      setState(() {
        this.loading = false;
      });
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
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Loading',
                  valueColor: AlwaysStoppedAnimation(ThemeColors.primary),
                ),
              )
            : person == null
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Fail to load data'),
                      ElevatedButton(
                          onPressed: load,
                          child: Text('Try again'),
                          style: ElevatedButton.styleFrom(
                              primary: ThemeColors.primary)),
                    ],
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          person!.avatar,
                          alignment: Alignment.topLeft,
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width > 600
                              ? null
                              : double.infinity,
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
                          padding: const EdgeInsets.only(
                              top: 12, left: 16, bottom: 24),
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
