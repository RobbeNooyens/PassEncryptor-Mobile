import 'package:passencryptor/core/algorithms/operations.dart';

class Algorithms {
    // "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890123456789!\"#$%&()*+-/<=>?@[]_{}"
    static String chars = "abcdeLMNOPQRST}fghstqrXYZ01234<=>?@[567890123UVWijklmno-/]_{45uvp6789!\"#\$%&()*+wxyzABCDEFGHIJK";

    String shift(final String s, final int positions, final Operations operation){
        String output = "";
        for(int i = 0; i < s.length; i++)
            output += intToChar(Operation.apply(operation, charToInt(s[i]), positions));
        return output;
    }

    String merge(final String s1, final String s2, final Operations operation){
        String output = "";
        for(int i = 0; i < s1.length || i < s2.length; i++){
            String c1 = s1[i % s1.length];
            String c2 = s2[i % s2.length];
            int sum = Operation.apply(operation, charToInt(c1), charToInt(c2));
            output += intToChar(sum);
        }
        return output;
    }

    String compress(String s){
        String temp = "";
        for(int c = 0; c < s.length; c++) {
            temp += (charToInt(s[c]) / 10).floor().toString();
            temp += (charToInt(s[c]) % 10).floor().toString();
        }
        String output = "";
        for(int i = 0; i < temp.length-2; i+=3){
          String substring = temp.substring(i, i+2);
            int index = int.parse(substring);
            output += (intToChar(index));
        }
        return output;
    }

    String reverse(final String s){
        return s.split('').reversed.join('');
    }

    String invertIndividualChars(String s) {
        String builder = "";
        int i = 0;
        for(int c = 0; c < s.length; c++)
            builder += (i++ % 2) == 0 ? invertedChar(s[c]) : s[c];
        return builder;
    }

    String split(String s, int splitIndex){
        String s1 = s.substring(0, (splitIndex % s.length));
        String s2 = s.substring(splitIndex % s.length);
        return s2 + s1;
    }

    String endingAlgorithm(String s){
        String builder = "";
        int i = 0;
        for(int c = 0; c < s.length; c++)
            builder += (i++ % 2) == 0 ? intToChar(charToInt(s[c]) + (sumOfChars(s) % (i + 1))) : s[c];
        return builder.toString();
    }

    String complement(String s){
        String output = "";
        for(int i = 0; i < s.length; i++)
            output += intToChar(chars.length - charToInt(s[i]));
        return output.toString();
    }

    String ensureRequirements(String s){
        String lowercase = "abcdefghijklmnopqrstuvwxyz";
        String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String numbers = "0123456789";
        String specials = "!\"#\$%&()*+-/<=>?@[]_{}";
        int sum = sumOfChars(s);
        sum = sum * sum;
        String prefix = (lowercase[sum % lowercase.length] + uppercase[sum % uppercase.length] + numbers[sum % numbers.length] +
                specials[sum % specials.length]).toString();
        return prefix + s;
    }

    String simplify(String s){
        String allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!";
        String output = "";
        for(int i = 0; i < s.length; i++)
          output += allowedChars[chars.indexOf(s[i]) % allowedChars.length];
        int pos = sumOfChars(output.toString()) % output.length;
        String part1 = output.substring(0, pos);
        String part2 = output.substring(pos);
        return part1 + "!" + part2;
    }



    // Helpers

    int charToInt(String c){
        return chars.indexOf(c);
    }

    String intToChar(int i){
        return chars[i % chars.length];
    }

    int sumOfChars(String s){
        int output = 0;
        for(int c = 0; c < s.length; c++)
            output += charToInt(s[c]);
        return output;
    }

    String invertedChar(String s){
        int intVal = charToInt(s);
        int index0 = intVal % 10;
        int index1 = (intVal / 10).floor();
        int invertedVal = int.parse("$index0$index1");
        return intToChar(invertedVal);
    }

}