// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:bloc_first/bloc/bloc_actions.dart';
import 'package:bloc_first/bloc/person.dart';
import 'package:bloc_first/bloc/persons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => PersonsBloc(),
        child: const MyHomePage(title: 'Flutter Bloc First'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Bloc bloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<PersonsBloc>().add(
                          const LoadPersonsAction(
                            url: persons1Url,
                            loader: getPersons,
                          ),
                        );
                  },
                  child: const Text("JSON 1")),
              const SizedBox(width: 24),
              ElevatedButton(
                  onPressed: () {
                    context.read<PersonsBloc>().add(
                          const LoadPersonsAction(
                            url: persons2Url,
                            loader: getPersons,
                          ),
                        );
                  },
                  child: const Text("JSON 2")),
            ],
          ),
          BlocBuilder<PersonsBloc, FetchResult?>(
            buildWhen: (previousResultState, currentResultState) =>
                previousResultState?.persons != currentResultState?.persons,
            builder: (context, fetchResultState) {
              final persons = fetchResultState?.persons;
              fetchResultState?.log();
              if (persons == null) {
                return const SizedBox();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: persons.length,
                  itemBuilder: (_, idx) {
                    final pers = persons[idx]!;
                    return ListTile(
                      title: Text(pers.name),
                      subtitle: Text(pers.age.toString()),
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}

Future<Iterable<Person>> getPersons(String url) {
  return HttpClient()
      .getUrl(Uri.parse(url))
      .then((req) => req.close())
      .then((res) => res.transform(utf8.decoder).join())
      .then((str) => json.decode(str) as List<dynamic>)
      .then((list) => list.map((p) => Person.fromMap(p)));
}
