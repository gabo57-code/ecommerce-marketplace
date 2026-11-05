package com.marketplace.marketplace.repository;

import com.marketplace.marketplace.model.PurchaseOrder;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PurchaseOrderRepository extends JpaRepository<PurchaseOrder, Long> {
    List<PurchaseOrder> findByBuyerEmailOrderByCreatedAtDesc(String email);
    Optional<PurchaseOrder> findByIdAndBuyerEmail(Long id, String email);
}
