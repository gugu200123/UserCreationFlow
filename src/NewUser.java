import java.util.Scanner;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class NewUser {
    private static final Pattern emailPattern = Pattern.compile("^[\\w-\\.]+@[\\w-]+\\.[a-z]{2,3}(\\.[a-z]{2})?$");

    public void createUser(UserDAO userDAO) {
        Scanner myscan = new Scanner(System.in);
        String firstName;
        do {
            System.out.println("Qual o primeiro nome do usuario? (Até 30 caracteres)");
            firstName = myscan.nextLine();
            if (firstName.length() > 30) {
                System.out.println("O primeiro nome deve ter no máximo 30 caracteres.");
            }
        } while (firstName.length() > 30);


        String lastName;
        do {
            System.out.println("Qual o ultimo nome do usuario? (Até 30 caracteres)");
            lastName = myscan.nextLine();
            if (lastName.length() > 30) {
                System.out.println("O último nome deve ter no máximo 30 caracteres.");
            }
        } while (lastName.length() > 30);


        System.out.println("Qual a senha desejada?");

        String salt = PassHash.generateSalt();

        String hashedPassword = PassHash.hash(myscan.nextLine(), salt);


        String email;
        Matcher matcher;
        do {
            System.out.println("Qual o E-mail do usuario?");
            email = myscan.nextLine();
            matcher = emailPattern.matcher(email);
            if (!matcher.matches()) {
                System.out.println("Por favor, insira um e-mail válido.");
            }
        } while (!matcher.matches());

        userDAO.addUser(firstName, lastName, hashedPassword, email,salt);
    }
}
