package com.marketplace.marketplace.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@AllArgsConstructor
public class CartSummary {
    private final List<CartLine> lines;
    private final BigDecimal total;
    private final int units;
}
