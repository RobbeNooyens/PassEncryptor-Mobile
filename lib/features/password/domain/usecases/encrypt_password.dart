import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:passencryptor/core/error/failures.dart';
import 'package:passencryptor/core/usecases/usecase.dart';
import 'package:passencryptor/features/password/domain/entities/password.dart';
import 'package:passencryptor/features/password/domain/repositories/password_repository.dart';
import 'package:meta/meta.dart';

class EncryptPassword implements UseCase<Password, Params> {
  final PasswordRepository repository;

  EncryptPassword(this.repository);

  @override
  Future<Either<Failure, Password>> call(Params params) async {
    return await repository.encryptPassword(params.encryptionKey, params.application);
  }
}

class Params extends Equatable {
  final String encryptionKey, application;

  Params({@required this.encryptionKey, @required this.application});

  @override
  List<Object> get props => [encryptionKey, application];
}