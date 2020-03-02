import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        Reader reader = new FileReader("input.txt");
        SimpleLexer lexer = new SimpleLexer(reader);

        String token;
        while ((token = lexer.yylex()) != null) {
            System.out.println(token);
        }
    }
}
