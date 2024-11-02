import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public void addUser(String firstName, String lastName, String passwordHash, String email,String salt) {
        String sql = "INSERT INTO Users (UserFirstName, UserLastName, PasswordHash, Email, Salt) VALUES (?, ?, ?, ?,?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, passwordHash);
            pstmt.setString(4, email);
            pstmt.setString(5, salt);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void getUsers() {
        String sql = "SELECT * FROM Users";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                System.out.println("UserID: " + rs.getInt("UserID") +
                                   ", First Name: " + rs.getString("UserFirstName") +
                                   ", Last Name: " + rs.getString("UserLastName") +
                                   ", Email: " + rs.getString("Email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
    public void deleteUser(String email) {
        String sql = "DELETE FROM users WHERE email = ?"; // Certifique-se de que a tabela e coluna estão corretas

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Usuário removido com sucesso.");
            } else {
                System.out.println("Usuário com o email '" + email + "' não encontrado.");
            }

        } catch (SQLException e) {
            System.out.println("Erro ao tentar deletar usuário: " + e.getMessage());
        }
    }
     public boolean login(String email, String password) {
        String sql = "SELECT PasswordHash, salt FROM users WHERE email = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("PasswordHash");
                String salt = rs.getString("salt");

                String hashedPassword = PassHash.hash(password, salt);

                return storedHash.equals(hashedPassword); // Compara o hash armazenado com o hash gerado
            }
        } catch (SQLException e) {
            System.out.println("Erro ao fazer login: " + e.getMessage());
        }

        return false;
    }

}
