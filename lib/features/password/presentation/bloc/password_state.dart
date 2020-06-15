part of 'password_bloc.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();
  @override
  List<Object> get props => [];
}

class Empty extends PasswordState {}

class Loading extends PasswordState {}

class Loaded extends PasswordState {
  final Password password;

  Loaded(this.password);

  @override
  List<Object> get props => [password];
}

class Error extends PasswordState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

