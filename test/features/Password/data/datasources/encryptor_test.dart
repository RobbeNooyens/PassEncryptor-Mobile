import 'package:flutter_test/flutter_test.dart';
import 'package:passencryptor/features/password/data/datasources/encryptor.dart';

void main(){
  Encryptor encryptor;
  String tEncryptionKey, tApp;
  setUp((){
    tEncryptionKey = "TestKey";
    tApp = "TestApp";
    encryptor = Encryptor(encryptionKey: tEncryptionKey, application: tApp);
  });

  test(
    'should encrypt password',
    ()async {
      // arrange
      
      // act
      String encrypted = encryptor.generate();
      String encryptedSimple = encryptor.generateSimple();
      // assert
      expect(encrypted, "wW4@d-wKy<w]vFwG_K0");
      expect(encryptedSimple, "qV!DId3qEsEq5azqA6Ez");
    },
  );
}