package com.marketplace.marketplace.dto;

import com.marketplace.marketplace.model.Product;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.math.BigDecimal;

/** Una fila del carrito, lista para mostrarse. */
@Getter
@AllArgsConstructor
public class CartLine {
    private final Long itemId;
    private final Product product;
    private final int quantity;
    private final BigDecimal subtotal;
    private final boolean available;   // false si ya no hay stock suficiente
}
