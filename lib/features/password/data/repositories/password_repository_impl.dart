import 'package:passencryptor/core/algorithms/algorithms.dart';
import 'package:passencryptor/features/password/data/datasources/encryptor.dart';
import 'package:passencryptor/features/password/domain/entities/password.dart';
import 'package:passencryptor/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:passencryptor/features/password/domain/repositories/password_repository.dart';

class PasswordRepositoryImpl implements PasswordRepository {

  @override
  Future<Either<Failure, Password>> encryptPassword(String encryptionKey, String application) {
    if(!isValid(encryptionKey)) return Future.value(Left(EncryptionKeyFailure()));
    if(!isValid(application)) return Future.value(Left(ApplicationFailure()));
    Encryptor encryptor = new Encryptor(application: application, encryptionKey: encryptionKey);
    return Future.value(Right(Password(encryptor.generate())));
  }

  @override
  Future<Either<Failure, Password>> encryptSimplifiedPassword(String encryptionKey, String application) {
    if(!isValid(encryptionKey)) return Future.value(Left(EncryptionKeyFailure()));
    if(!isValid(application)) return Future.value(Left(ApplicationFailure()));
    Encryptor encryptor = new Encryptor(application: application, encryptionKey: encryptionKey);
    return Future.value(Right(Password(encryptor.generateSimple())));
  }

  bool isValid(String input){
    if(input == null) return false;
    if(input.length == 0) return false;
    for(int c = 0; c < input.length; c++)
      if(!Algorithms.chars.contains(input[c])) return false;
    return true;
  }
  
}