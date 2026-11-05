package com.marketplace.marketplace.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BecomeSellerForm {

    @NotBlank(message = "Escribe el nombre de tu tienda")
    @Size(max = 100, message = "Máximo 100 caracteres")
    private String storeName;
}
