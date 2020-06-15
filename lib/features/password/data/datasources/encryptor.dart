import 'package:passencryptor/core/algorithms/algorithms.dart';
import 'package:passencryptor/core/algorithms/operations.dart';
import 'package:meta/meta.dart';

class Encryptor {

    String inputKey;
    String inputApplication;
    String generatedPassword;

    Encryptor({@required String encryptionKey, @required String application}){
        this.inputKey = fill(encryptionKey, 30, 50);
        this.inputApplication = ensureEqualApplicationNames(application);
    }

    String generate() {
        final Algorithms algorithms = Algorithms();
        final String shiftedApplication = algorithms.shift(inputApplication, 3, Operations.ADD);
        final String initial = algorithms.merge(inputKey, shiftedApplication, Operations.ADD);
        // All fine here
        generatedPassword = algorithms.compress(initial);
        for(int i = 0; i < initial.length; i++){
            switch (algorithms.charToInt(initial[i]) % 7){
                case 0:
                    generatedPassword = algorithms.shift(generatedPassword, (i/2).floor(), Operations.ADD);
                    break;
                case 1:
                    generatedPassword = algorithms.shift(generatedPassword, 2, Operations.MULTIPLY);
                    break;
                case 2:
                    generatedPassword = algorithms.invertIndividualChars(generatedPassword);
                    break;
                case 3:
                    generatedPassword = algorithms.split(generatedPassword, (i+1)*2);
                    continue fallthrough
                    ;
                fallthrough:
                case 4:
                    generatedPassword = algorithms.reverse(generatedPassword);
                    break;
                case 5:
                    generatedPassword = algorithms.shift(generatedPassword, i, Operations.ADD);
                    break;
                case 6:
                    generatedPassword = algorithms.shift(generatedPassword, 6, Operations.ADD);
                    break;
                default:
                    generatedPassword = algorithms.shift(generatedPassword, 3, Operations.MULTIPLY);
            }
        }
        generatedPassword = algorithms.compress(generatedPassword);
        generatedPassword = algorithms.endingAlgorithm(generatedPassword);
        generatedPassword = algorithms.complement(generatedPassword);
        generatedPassword = algorithms.ensureRequirements(generatedPassword);
        return generatedPassword;
    }

    String generateSimple() {
        final Algorithms algorithms = new Algorithms();
        return algorithms.simplify(generate());
    }

    String fill(final String s, final int minCap, final int maxCap){
        String output = s;
        Algorithms compression = new Algorithms();
        while(output.length < minCap )
            output = compression.reverse(output) + compression.shift(s, output.length, Operations.ADD);
        while(output.length > maxCap)
            output = compression.compress(output);
        return output;
    }

    String ensureEqualApplicationNames(final String application){
        return application.toLowerCase().replaceAll("[ .,_:;&]", "").replaceAll("-", "");
    }
}