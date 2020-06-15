import 'package:equatable/equatable.dart';

class Password extends Equatable {
  final String encrypted;

  Password(this.encrypted);

  @override
  List<Object> get props => [encrypted];
  
}