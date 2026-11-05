package com.marketplace.marketplace.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Set;
import java.util.UUID;

/** Guarda las imágenes subidas en la carpeta "uploads" (en la raíz del proyecto). */
@Service
public class FileStorageService {

    private static final Set<String> ALLOWED = Set.of("jpg", "jpeg", "png", "webp", "gif");
    private final Path root = Paths.get("uploads").toAbsolutePath().normalize();

    /** Devuelve la URL pública, por ejemplo: /uploads/abc123.png */
    public String store(MultipartFile file) {
        String original = file.getOriginalFilename();
        String ext = (original != null && original.contains("."))
                ? original.substring(original.lastIndexOf('.') + 1).toLowerCase()
                : "";
        String type = file.getContentType();

        if (!ALLOWED.contains(ext) || type == null || !type.startsWith("image/")) {
            throw new IllegalArgumentException("Solo se permiten imágenes JPG, PNG, WEBP o GIF");
        }

        try {
            Files.createDirectories(root);
            String filename = UUID.randomUUID() + "." + ext;
            try (InputStream in = file.getInputStream()) {
                Files.copy(in, root.resolve(filename), StandardCopyOption.REPLACE_EXISTING);
            }
            return "/uploads/" + filename;
        } catch (IOException e) {
            throw new IllegalStateException("No se pudo guardar la imagen", e);
        }
    }
}
