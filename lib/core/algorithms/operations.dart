class Operation {
    static int apply(Operations operation, int num1, int num2){
        switch (operation){
            case Operations.MULTIPLY:
                return num1 * num2;
            case Operations.DIVIDE:
                return (num1/num2).round();
            case Operations.ADD:
                return num1 + num2;
            case Operations.SUBTRACT:
                return num1 - num2;
        }
        return 0;
    }
}

enum Operations {MULTIPLY, DIVIDE, ADD, SUBTRACT}
