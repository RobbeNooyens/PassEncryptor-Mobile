import 'package:dartz/dartz.dart';
import 'package:passencryptor/core/error/failures.dart';
import 'package:passencryptor/features/password/domain/entities/password.dart';

abstract class PasswordRepository {
  Future<Either<Failure, Password>> encryptPassword(String encryptionKey, String application);
  Future<Either<Failure, Password>> encryptSimplifiedPassword(String encryptionKey, String application);
}