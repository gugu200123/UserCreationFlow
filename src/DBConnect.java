import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    private static final String URL = "jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=UserManagementDB;encrypt=false;trustServerCertificate=true";
    private static final String USER = "UsuarioParaTeste";
    private static final String PASSWORD = "Gugu/2001";

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
