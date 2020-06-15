import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:passencryptor/core/error/failures.dart';
import 'package:passencryptor/core/usecases/usecase.dart';
import 'package:passencryptor/features/password/domain/entities/password.dart';
import 'package:passencryptor/features/password/domain/repositories/password_repository.dart';
import 'package:meta/meta.dart';

class EncryptSimplifiedPassword implements UseCase<Password, SimplifiedParams> {
  final PasswordRepository repository;

  EncryptSimplifiedPassword(this.repository);

  @override
  Future<Either<Failure, Password>> call(SimplifiedParams params) async {
    return await repository.encryptSimplifiedPassword(params.encryptionKey, params.application);
  }
}

class SimplifiedParams extends Equatable {
  final String encryptionKey, application;

  SimplifiedParams({@required this.encryptionKey, @required this.application});

  @override
  List<Object> get props => [encryptionKey, application];
}