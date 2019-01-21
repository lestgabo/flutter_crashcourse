import 'dart:convert';
import 'package:fluttercrashcourse_lesson12/models/location.dart';
import 'package:test/test.dart';
import 'dart:developer';

void main() {
  // real test
  // async and await makes code readable and like synchronous
  test('test /locations and /locations/:id', () async {
    final locations = await Location.fetchAll();
    for (var location in locations) {
      expect(location.name, hasLength(greaterThan(0)));
      expect(location.url, hasLength(greaterThan(0)));

      final fetchedLocation = await Location.fetchByID(location.id);
      expect(fetchedLocation.name, equals(location.name));
      expect(fetchedLocation.url, equals(location.url));
//      print(fetchedLocation.facts);
//      debugger(when: fetchedLocation.facts != null);
//      print(fetchedLocation.url);
      expect(fetchedLocation.facts, hasLength(2));
    }
  });
}
