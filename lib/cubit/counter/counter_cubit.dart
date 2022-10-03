import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit()
      : super(CounterState(
          counterValue: 1,
          wasIncremented: false,
        ));

  void increment() {
    if (state.counterValue == 5) {
      emit(CounterState(
        counterValue: state.counterValue,
        wasIncremented: true,
      ));
    } else {
      emit(CounterState(
        counterValue: state.counterValue + 1,
        wasIncremented: true,
      ));
    }
  }

  void decrement() {
    if (state.counterValue == 1) {
      emit(CounterState(
        counterValue: state.counterValue,
        wasIncremented: false,
      ));
    } else {
      emit(CounterState(
        counterValue: state.counterValue - 1,
        wasIncremented: false,
      ));
    }
  }
}
