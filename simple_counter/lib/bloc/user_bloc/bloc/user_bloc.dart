import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_counter/bloc/bloc_counter.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CounterBloc counterBloc;
  late final StreamSubscription subCounterBloc;

  UserBloc(this.counterBloc) : super(const UserInitial()) {
    subCounterBloc = counterBloc.stream.listen((event) {
      print('COunterState in UserBloc: ${event.count}');
      if (event.count == 0) {
        // add(GetJobsEvent(count: 0));
        add(GetUsersEvent(count: 0));
      }
    });
    on<GetUsersEvent>(getUsers);
    on<GetJobsEvent>(getJobs);
  }

  @override
  Future<void> close() async {
    subCounterBloc.cancel();
    return super.close();
  }

  void getUsers(GetUsersEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final users = List.generate(
      event.count,
      (index) => User(
        name: 'Nik_$index',
        id: index.toString(),
      ),
    );
    emit(state.copyWith(isLoading: false, users: users));
  }

  void getJobs(GetJobsEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isJobsLoading: true));
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final jobs = List.generate(
      event.count,
      (index) => Job(
        title: 'JOb_$index',
        id: index.toString(),
      ),
    );
    emit(state.copyWith(isJobsLoading: false, jobs: jobs));
  }
}
