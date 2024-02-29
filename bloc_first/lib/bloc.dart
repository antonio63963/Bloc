import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction extends LoadAction {
  final PersonUrl url;
  const LoadPersonsAction({required this.url}) : super();
}

enum PersonUrl {
  persons1,
  persons2,
}

//connection by life server (shift ctrl p => life server)
extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.persons1:
        return 'http://10.0.2.2:5500/bloc_first/api/persons1.json';
      case PersonUrl.persons2:
        return 'http://10.0.2.2:5500/bloc_first/api/persons2.json';
    }
  }
}

@immutable
class Person {
  final String name;
  final int age;
  const Person({
    required this.name,
    required this.age,
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  @override
  String toString() => 'Person(name = $name , age = $age)';
}

Future<Iterable<Person>> getPersons(String url) {
  return HttpClient()
      .getUrl(Uri.parse(url))
      .then((req) => req.close())
      .then((res) {
        print('GET PERD: $res');
        return res.transform(utf8.decoder).join();
      })
      .then((str) => json.decode(str) as List<dynamic>)
      .then((list) => list.map((p) => Person.fromMap(p)));
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCach;

  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCach,
  });

  @override
  String toString() {
    super.toString();
    return '''
      +++FetchResult:
      isRetrievedFromCache: $isRetrievedFromCach,
      persons: $persons
    ''';
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPersons = _cache[url];
        final result =
            FetchResult(persons: cachedPersons!, isRetrievedFromCach: true);
        emit(result);
      } else {
        final persons = await getPersons(url.urlString);
        _cache[url] = persons;
        final result = FetchResult(
          isRetrievedFromCach: false,
          persons: persons,
        );
        emit(result);
      }
    });
  }
}
