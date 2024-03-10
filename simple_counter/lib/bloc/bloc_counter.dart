import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_counter/bloc/actions_counter.dart';
import 'package:simple_counter/bloc/state_counter.dart';

class CounterBloc extends Bloc<CounterAction, StateCounter> {
  CounterBloc() : super(const StateCounter(0)) {
    on<IncreaseAction>((event, emit) {
      print('INCREASE STATE: ${state.count}');
      emit(
        StateCounter(state.count + 1),
      );
    });
    on<DecreaseAction>(
      (event, emit) => emit(
        StateCounter(state.count - 1),
      ),
    );
  }
}
