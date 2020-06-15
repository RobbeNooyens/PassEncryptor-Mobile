import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  @override
  PasswordState get initialState => PasswordInitial();
  @override
  Stream<PasswordState> mapEventToState(
    PasswordEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
