package com.marketplace.marketplace.repository;

import com.marketplace.marketplace.model.Address;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AddressRepository extends JpaRepository<Address, Long> {
    List<Address> findByUserEmailOrderByIdDesc(String email);
}
