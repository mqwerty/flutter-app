import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'models.dart';

const baseUrl = 'https://rickandmortyapi.com/api/';

Future<List<Person>> loadPersonList() async {
  final response = await http.get(Uri.parse(baseUrl + 'character'));
  if (response.statusCode != 200) {
    throw Exception('Failed to load');
  }

  List<Person> results = [];
  List<dynamic> items = convert.jsonDecode(response.body)['results'];
  for (final item in items) {
    Person person = Person();
    person.id = item['id'];
    person.name = item['name'];
    person.status = item['status'];
    person.url = item['url'];
    person.image = item['image'];
    results.add(person);
  }

  return results;
}

Future<PersonDetails> loadPersonDetails(int id) async {
  final response = await http.get(Uri.parse(baseUrl + 'character/$id'));
  if (response.statusCode != 200) {
    throw Exception('Failed to load');
  }

  final item = convert.jsonDecode(response.body);
  final person = PersonDetails();
  person.id = item['id'];
  person.name = item['name'];
  person.avatar = item['image'];
  person.locationName = item['location']['name'];
  person.locationUrl = item['location']['url'];
  person.status = item['status'];
  person.created = item['created'];
  person.type = item['type'];
  person.gender = item['gender'];
  person.species = item['species'];
  person.originName = item['origin']['name'];
  person.originUrl = item['origin']['url'];
  //  person.episodes = item['episode'];
  return person;
}
