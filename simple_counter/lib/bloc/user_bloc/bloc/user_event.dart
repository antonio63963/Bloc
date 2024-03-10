part of 'user_bloc.dart';

@immutable
abstract interface class UserEvent {}

class GetUsersEvent extends UserEvent {
  final int count;
  GetUsersEvent({required this.count});
}

class GetJobsEvent extends UserEvent {
  final int count;
  GetJobsEvent({required this.count});
}

class ResetUserBloc extends UserEvent {}
