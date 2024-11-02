import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        NewUser newUser = new NewUser();
        Scanner myscan = new Scanner(System.in);
        Integer menu = 10;


        System.out.println("Digite seu E-mail:");
        String email = myscan.nextLine();

        System.out.println("Digite sua Senha:");
        String password = myscan.nextLine();

        if (userDAO.login(email, password)) {
            System.out.println("Login bem-sucedido!");
            while (menu != 0) {
            System.out.println("1-Cadastrar novo usuario");
            System.out.println("2-Conferir lista de usuarios");
            System.out.println("3-Deletar usuario");
            System.out.println("0-Sair");
            System.out.println("--Escolha uma opção:");
            menu = myscan.nextInt();
            myscan.nextLine();

            if (menu == 1) {
                newUser.createUser(userDAO);
            } else if (menu == 2) {
                userDAO.getUsers();
            } else if (menu == 3) {
                System.out.println("Digite o email do usuário a ser deletado:");
                email = myscan.nextLine();
                userDAO.deleteUser(email);
            } else if (menu == 0) {
                String saida = "T";
                while (!saida.equals("S") && !saida.equals("N")) {
                    System.out.println("Deseja realmente sair do sistema S/N");
                    saida = myscan.nextLine().toUpperCase();
                    if (saida.equals("S")) {
                        menu = 0;
                    } else if (saida.equals("N")) {
                        menu = 10;
                    } else {
                        System.out.println("Não compreendi, digite novamente");
                    }
                }
            }

        }
        } else {
            System.out.println("E-mail ou senha inválidos.");
        }


        myscan.close();
    }
}
