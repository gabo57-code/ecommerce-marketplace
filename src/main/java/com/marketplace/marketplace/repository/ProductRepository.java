package com.marketplace.marketplace.repository;

import com.marketplace.marketplace.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long> {

    // ---------- Vendedor ----------
    List<Product> findByStoreSellerEmailAndActiveTrueOrderByCreatedAtDesc(String email);

    Optional<Product> findByIdAndStoreSellerEmailAndActiveTrue(Long id, String email);

    // ---------- Comprador ----------
    Optional<Product> findByIdAndActiveTrue(Long id);

    /**
     * Catálogo paginado: solo productos activos y con stock.
     * categoryId = 0 significa "todas las categorías".
     * q = "" significa "sin búsqueda".
     * El orden (más recientes, precio...) lo define el Pageable que recibe.
     */
    @Query(value = """
           SELECT p FROM Product p
           WHERE p.active = true
             AND p.stock > 0
             AND (:categoryId = 0 OR p.category.id = :categoryId)
             AND LOWER(p.name) LIKE LOWER(CONCAT('%', :q, '%'))
           """,
            countQuery = """
           SELECT COUNT(p) FROM Product p
           WHERE p.active = true
             AND p.stock > 0
             AND (:categoryId = 0 OR p.category.id = :categoryId)
             AND LOWER(p.name) LIKE LOWER(CONCAT('%', :q, '%'))
           """)
    Page<Product> search(@Param("categoryId") Long categoryId,
                         @Param("q") String q,
                         Pageable pageable);

    /**
     * Descuenta stock de forma ATÓMICA: solo si el producto sigue activo y hay
     * unidades suficientes. Devuelve 1 si se descontó, o 0 si ya no alcanzaba
     * (otra compra se llevó el stock en ese instante).
     */
    @Modifying
    @Query("UPDATE Product p SET p.stock = p.stock - :qty "
            + "WHERE p.id = :id AND p.active = true AND p.stock >= :qty")
    int decrementStock(@Param("id") Long id, @Param("qty") int qty);
}