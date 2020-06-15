import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/password.dart';
import '../../domain/usecases/encrypt_password.dart';
import '../../domain/usecases/encrypt_simplified_password.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final EncryptPassword encryptPassword;
  final EncryptSimplifiedPassword encryptSimplifiedPassword;

  PasswordBloc(EncryptPassword encryptPassword, EncryptSimplifiedPassword encryptSimplifiedPassword) :
    assert(encryptPassword != null),
    assert(encryptSimplifiedPassword != null),
    this.encryptPassword = encryptPassword,
    this.encryptSimplifiedPassword = encryptSimplifiedPassword;

  @override
  PasswordState get initialState => Empty();
  @override
  Stream<PasswordState> mapEventToState(
    PasswordEvent event,
  ) async* {
    if(event is EncryptPasswordEvent) {
      yield Loading();
      final failureOrPassword = await encryptPassword(Params(encryptionKey: event.encryptionKey, application: event.application));
      yield* _eitherLoadedOrErrorState(failureOrPassword);
    } else if(event is EncryptSimplifiedPasswordEvent) {
      yield Loading();
      final failureOrPassword = await encryptSimplifiedPassword(SimplifiedParams(encryptionKey: event.encryptionKey, application: event.application));
      yield* _eitherLoadedOrErrorState(failureOrPassword);
    }
  }
  Stream<PasswordState> _eitherLoadedOrErrorState(
    Either<Failure, Password> failureOrPassword,
  ) async* {
    yield failureOrPassword.fold(
      (failure) => Error(failure.message),
      (password) => Loaded(password),
    );
  }
}
