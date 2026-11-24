
package util;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;

public class SupabaseStorage {

    private static String endpoint() {
        return SupabaseUtil.getUrl()
                + "/storage/v1/object/";
    }

    // SUBIR ARCHIVOS A SUPABASE
    public static void subir(String ruta, byte[] datos)
            throws IOException {

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint()
                        + SupabaseUtil.BUCKET + "/" + ruta))
                .header("apikey", SupabaseUtil.getKey())
                .header("Content-Type", "application/octet-stream")
                .header("x-upsert", "false")
                .timeout(Duration.ofMinutes(2))
                .POST(HttpRequest.BodyPublishers.ofByteArray(datos))
                .build();

        ejecutar(request);
    }

    // DESCARGAR ARCHIVOS DE SUPABASE
    public static InputStream descargar(String ruta)
            throws IOException {

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint()
                        + "authenticated/"
                        + SupabaseUtil.BUCKET + "/" + ruta))
                .header("apikey", SupabaseUtil.getKey())
                .timeout(Duration.ofMinutes(2))
                .GET()
                .build();

        try {
            HttpResponse<InputStream> respuesta =
                    SupabaseUtil.CLIENT.send(
                            request,
                            HttpResponse.BodyHandlers.ofInputStream());

            if (respuesta.statusCode() != 200) {
                respuesta.body().close();

                throw new IOException(
                        "Error al descargar archivo: "
                                + respuesta.statusCode());
            }

            return respuesta.body();

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException(e);
        }
    }

    // ELIMINAR ARCHIVOS DE SUPABASE
    public static void eliminar(String ruta)
            throws IOException {

        String json = new Gson().toJson(
                Map.of("prefixes", List.of(ruta)));

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint()
                        + SupabaseUtil.BUCKET))
                .header("apikey", SupabaseUtil.getKey())
                .header("Content-Type", "application/json")
                .timeout(Duration.ofSeconds(60))
                .method("DELETE",
                        HttpRequest.BodyPublishers.ofString(json))
                .build();

        ejecutar(request);
    }

    // EJECUTAR PETICIONES HTTP
    private static void ejecutar(HttpRequest request)
            throws IOException {

        try {
            HttpResponse<String> respuesta =
                    SupabaseUtil.CLIENT.send(
                            request,
                            HttpResponse.BodyHandlers.ofString());

            if (respuesta.statusCode() < 200
                    || respuesta.statusCode() >= 300) {

                throw new IOException(
                        "Error de Supabase: "
                                + respuesta.statusCode());
            }

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException(e);
        }
    }
}
