import 'package:bloc_first/bloc/bloc_actions.dart';
import 'package:bloc_first/bloc/person.dart';
import 'package:bloc_first/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_first/bloc/person.dart';

const persons1Url = 'http://10.0.2.2:5500/bloc_first/api/persons1.json';
const persons2Url = 'http://10.0.2.2:5500/bloc_first/api/persons2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

const mockedPersons1 = [
  Person(name: 'Mike', age: 32),
  Person(name: 'Bill', age: 12),
];
const mockedPersons2 = [
  Person(name: 'Den', age: 44),
  Person(name: 'Ann', age: 32),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPersons1);
Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing bloc', () {
    late PersonsBloc bloc;

    setUp(() => bloc = PersonsBloc());

    blocTest<PersonsBloc, FetchResult?>(
      'Test initial state',
      build: () => bloc,
      verify: (bloc) => bloc.state == null,
    );
// the same test other one variant
    test('initial state is null', () {
      expect(bloc.state, equals(null));
    });

    blocTest('Mock request 1 persons and then check if cached',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
              const LoadPersonsAction(url: 'url1', loader: mockGetPersons1));
          bloc.add(
              const LoadPersonsAction(url: 'url1', loader: mockGetPersons1));
        },
        expect: () => const [
              FetchResult(
                persons: mockedPersons1,
                isRetrievedFromCach: false,
              ),
              FetchResult(
                persons: mockedPersons1,
                isRetrievedFromCach: true,
              ),
            ]);
    //fetck mock data for perosns 2
    blocTest('Mock request 2 persons and then check if cached',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
              const LoadPersonsAction(url: 'url2', loader: mockGetPersons2));
          bloc.add(
              const LoadPersonsAction(url: 'url2', loader: mockGetPersons2));
        },
        expect: () => const [
              FetchResult(
                persons: mockedPersons2,
                isRetrievedFromCach: false,
              ),
              FetchResult(
                persons: mockedPersons2,
                isRetrievedFromCach: true,
              ),
            ]);
  });
}
