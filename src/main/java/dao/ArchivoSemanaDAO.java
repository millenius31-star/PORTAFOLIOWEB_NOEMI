
package dao;

import model.ArchivoSemana;
import util.SupabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class ArchivoSemanaDAO {

    public void guardar(int semana, ArchivoSemana archivo) {
        String sql = """
            INSERT INTO public.archivos_semanas
            (archivo_id, semana, tipo, nombre_original,
             ruta_storage, tamano)
            VALUES (?, ?, ?, ?, ?, ?)
            """;

        try (Connection con = SupabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setObject(1, UUID.fromString(archivo.getId()));
            ps.setInt(2, semana);
            ps.setString(3, archivo.getTipo());
            ps.setString(4, archivo.getNombreOriginal());
            ps.setString(5, archivo.getNombreGuardado());
            ps.setLong(6, archivo.getTamano());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new IllegalStateException(
                "Error al guardar archivo en Supabase", e);
        }
    }

    public List<ArchivoSemana> listar(int semana) {
        List<ArchivoSemana> lista = new ArrayList<>();

        String sql = """
            SELECT * FROM public.archivos_semanas
            WHERE semana = ?
            ORDER BY fecha_subida
            """;

        try (Connection con = SupabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, semana);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(convertir(rs));
                }
            }

        } catch (SQLException e) {
            throw new IllegalStateException(
                "Error al listar archivos", e);
        }

        return lista;
    }

    public ArchivoSemana buscar(String id) {
        if (id == null) return null;

        UUID uuid;

        try {
            uuid = UUID.fromString(id);
        } catch (IllegalArgumentException e) {
            return null;
        }

        String sql = """
            SELECT * FROM public.archivos_semanas
            WHERE archivo_id = ?
            """;

        try (Connection con = SupabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setObject(1, uuid);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return convertir(rs);
                }
            }

        } catch (SQLException e) {
            throw new IllegalStateException(
                "Error al buscar archivo", e);
        }

        return null;
    }

    public boolean eliminar(String id) {
        if (id == null) return false;

        UUID uuid;

        try {
            uuid = UUID.fromString(id);
        } catch (IllegalArgumentException e) {
            return false;
        }

        String sql = """
            DELETE FROM public.archivos_semanas
            WHERE archivo_id = ?
            """;

        try (Connection con = SupabaseUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setObject(1, uuid);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new IllegalStateException(
                "Error al eliminar archivo", e);
        }
    }

    private ArchivoSemana convertir(ResultSet rs)
            throws SQLException {

        return new ArchivoSemana(
            rs.getString("archivo_id"),
            rs.getString("nombre_original"),
            rs.getString("ruta_storage"),
            rs.getLong("tamano"),
            rs.getString("tipo")
        );
    }
}
