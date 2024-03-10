part of 'user_bloc.dart';

// @immutable
class UserState {
  final List<User> users;
  final List<Job> jobs;
  final bool isLoading;
  final bool isJobsLoading;

  const UserState({
    this.users = const [],
    this.jobs = const [],
    this.isLoading = false,
    this.isJobsLoading = false,
  });

  UserState copyWith({
    List<User>? users,
    List<Job>? jobs,
    bool isLoading = false,
    bool isJobsLoading = false,
  }) =>
      UserState(
        users: users ?? this.users,
        jobs: jobs ?? this.jobs,
        isLoading: isLoading,
        isJobsLoading: isJobsLoading,
      );
  @override
  String toString() {
    super.toString();
    return 'UserState(isJobsLoading: $isJobsLoading)';
  }
}

final class UserInitial extends UserState {
  const UserInitial();
}
// final class UserLoadingState extends UserState {}

// class UserLoadedState extends UserState {
//   final List<User> users;

//   UserLoadedState({required this.users});
// }

class User {
  final String name;
  final String id;

  User({required this.name, required this.id});
}

class Job {
  final String title;
  final String id;

  Job({required this.title, required this.id});
}
