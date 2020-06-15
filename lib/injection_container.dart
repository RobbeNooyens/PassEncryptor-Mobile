import 'package:get_it/get_it.dart';
import 'package:passencryptor/features/password/domain/usecases/encrypt_password.dart';
import 'package:passencryptor/features/password/domain/usecases/encrypt_simplified_password.dart';

import 'features/password/data/repositories/password_repository_impl.dart';
import 'features/password/domain/repositories/password_repository.dart';
import 'features/password/presentation/bloc/password_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => PasswordBloc(
      sl(),
      sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => EncryptPassword(sl()));
  sl.registerLazySingleton(() => EncryptSimplifiedPassword(sl()));

  // Repository
  sl.registerLazySingleton<PasswordRepository>(
    () => PasswordRepositoryImpl(),
  );  

  //! Core

  //! External
}