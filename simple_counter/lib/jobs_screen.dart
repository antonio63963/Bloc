import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_bloc/bloc/user_bloc.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: ((context, state) {
          print("STATE: ${state.toString()}");
          if (state.isJobsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.jobs.length,
              itemBuilder: (_, idx) {
                final u = state.jobs[idx];
                return ListTile(
                  title: Text(u.title),
                  subtitle: Text(u.id),
                );
              },
            );
          }
        }),
      ),
    );
  }
}