import 'package:bloc/bloc.dart';
import 'package:bloc_first/bloc/bloc_actions.dart';
import 'package:bloc_first/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
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

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrievedFromCach == other.isRetrievedFromCach;

  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCach);
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPersons = _cache[url];
        final result =
            FetchResult(persons: cachedPersons!, isRetrievedFromCach: true);
        emit(result);
      } else {
        final loader = event.loader;
        final persons = await loader(url);
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
