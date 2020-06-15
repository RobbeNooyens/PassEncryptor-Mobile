part of 'password_bloc.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();
  @override
  List<Object> get props => [];
}

class EncryptPasswordEvent extends PasswordEvent {
  final String encryptionKey, application;
  EncryptPasswordEvent({@required this.encryptionKey, @required this.application});
}
class EncryptSimplifiedPasswordEvent extends PasswordEvent {
  final String encryptionKey, application;
  EncryptSimplifiedPasswordEvent({@required this.encryptionKey, @required this.application});
}

