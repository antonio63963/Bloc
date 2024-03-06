import 'package:bloc_first/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;
//connection by life server (shift ctrl p => life server)

const persons1Url = 'http://10.0.2.2:5500/bloc_first/api/persons1.json';
const persons2Url = 'http://10.0.2.2:5500/bloc_first/api/persons2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction extends LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();
}
