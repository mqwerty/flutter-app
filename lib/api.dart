import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tuple/tuple.dart';

import 'models.dart';

const url = 'https://rickandmortyapi.com/graphql/';
var dio = Dio();

Future<Tuple2<List<Person>, int>> loadPersonList(int page) async {
  print('Page $page');

  final response = await dio.post(url, data: {
    'query': await rootBundle.loadString('graphql/personList.gql'),
    'variables': {'page': page},
  });

  if (response.data['data']['characters']['info'] == null ||
      response.data['data']['characters']['results'] == null) {
    throw Exception('Failed to load');
  }

  List<Person> results = [];
  for (final item in response.data['data']['characters']['results']) {
    Person person = Person();
    person.id = item['id'];
    person.name = item['name'];
    person.status = item['status'];
    person.image = item['image'];
    results.add(person);
  }

  return Tuple2(
      results, response.data['data']['characters']['info']['next'] ?? -1);
}

Future<PersonDetails> loadPersonDetails(String id) async {
  final response = await dio.post(url, data: {
    'query': await rootBundle.loadString('graphql/personDetails.gql'),
    'variables': {'id': id},
  });

  if (response.data['data']['character'] == null) {
    throw Exception('Failed to load');
  }

  final item = response.data['data']['character'];
  final person = PersonDetails();
  person.id = item['id'];
  person.name = item['name'];
  person.avatar = item['image'];
  person.status = item['status'];
  person.gender = item['gender'];
  person.species = item['species'];
  person.originName = item['origin']['name'];
  return person;
}
