
package util;

import java.net.http.HttpClient;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.Duration;

public class SupabaseUtil {

    public static final String BUCKET = "archivos-semanas";

    public static final HttpClient CLIENT =
            HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(30))
                    .build();

    private static String variable(String nombre) {

        String valor = System.getenv(nombre);

        if (valor == null || valor.isBlank()) {
            throw new IllegalStateException(
                    "Falta configurar la variable: " + nombre);
        }

        return valor;
    }

    public static String getUrl() {
        return variable("SUPABASE_URL")
                .replaceAll("/+$", "");
    }

    public static String getKey() {
        return variable("SUPABASE_SERVICE_ROLE_KEY");
    }

    public static Connection getConnection()
            throws SQLException {

        try {
            Class.forName("org.postgresql.Driver");

        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "No se encontro el driver PostgreSQL", e);
        }

        return DriverManager.getConnection(
                variable("DB_URL"),
                variable("DB_USER"),
                variable("DB_PASSWORD")
        );
    }
}
