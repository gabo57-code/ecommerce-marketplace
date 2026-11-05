package com.marketplace.marketplace.repository;

import com.marketplace.marketplace.model.OrderItem;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {

    /** ¿Este comprador ya compró este producto? (para permitirle dejar una reseña) */
    boolean existsByOrder_Buyer_EmailAndProduct_Id(String email, Long productId);

    /** Ventas de un vendedor: items de pedidos cuyos productos son de su tienda. */
    List<OrderItem> findByProduct_Store_Seller_Email(String email, Sort sort);
}
