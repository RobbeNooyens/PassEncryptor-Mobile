import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure(this.message);
  @override
  List<Object> get props => [];
}

class EncryptionKeyFailure extends Failure {
  EncryptionKeyFailure() : super("Invalid Encryption Key");
}

class ApplicationFailure extends Failure {
  ApplicationFailure() : super("Invalid Application");
}