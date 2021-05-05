import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'screenPersonList.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: ThemeColors.primary,
      ),
      title: 'Rick and Morty',
      home: PersonListScreen(),
      builder: EasyLoading.init(),
    );
  }
}
