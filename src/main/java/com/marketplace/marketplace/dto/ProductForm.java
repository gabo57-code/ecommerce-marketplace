package com.marketplace.marketplace.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class ProductForm {

    @NotBlank(message = "Escribe el nombre del producto")
    @Size(max = 150, message = "Máximo 150 caracteres")
    private String name;

    @Size(max = 2000, message = "Máximo 2000 caracteres")
    private String description;

    @NotNull(message = "Escribe el precio")
    @DecimalMin(value = "1", message = "El precio debe ser mayor a 0")
    @Digits(integer = 10, fraction = 2, message = "Precio no válido")
    private BigDecimal price;

    @NotNull(message = "Escribe las unidades disponibles")
    @Min(value = 0, message = "El stock no puede ser negativo")
    private Integer stock;

    @NotNull(message = "Selecciona una categoría")
    private Long categoryId;
}
