import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_counter/bloc/actions_counter.dart';
import 'package:simple_counter/bloc/bloc_counter.dart';
import 'package:simple_counter/bloc/state_counter.dart';
import 'package:simple_counter/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:simple_counter/jobs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => counterBloc,
        ),
        BlocProvider(
          create: (context) => UserBloc(counterBloc),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<CounterBloc>().add(IncreaseAction()),
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(width: 20),
                Text(context.watch<CounterBloc>().state.count.toString()),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () =>
                      context.read<CounterBloc>().add(DecreaseAction()),
                  icon: const Icon(Icons.minimize),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context
                  .read<UserBloc>()
                  .add(GetUsersEvent(count: counterBloc.state.count)),
              child: const Text('Users: '),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: ((context, state) {
                final users =
                    context.select((UserBloc bloc) => bloc.state.users);
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (_, idx) {
                      final u = users[idx];
                      return ListTile(
                        title: Text(u.name),
                        subtitle: Text(u.id),
                      );
                    },
                  );
                }
              }),
            ),

            // jobs
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: userBloc,
                              child: const JobsScreen(),
                            )));
                context
                    .read<UserBloc>()
                    .add(GetJobsEvent(count: counterBloc.state.count));
              },
              child: const Text('Jobs: '),
            ),
          ],
        ),
      ),
    );
  }
}
