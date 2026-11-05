package com.marketplace.marketplace.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckoutForm {

    @NotBlank(message = "Escribe tu dirección")
    @Size(max = 150, message = "Máximo 150 caracteres")
    private String street;

    @NotBlank(message = "Escribe tu ciudad")
    @Size(max = 80, message = "Máximo 80 caracteres")
    private String city;

    @NotBlank(message = "Escribe tu departamento")
    @Size(max = 80, message = "Máximo 80 caracteres")
    private String department;

    @Size(max = 15, message = "Máximo 15 caracteres")
    private String postalCode;

    @NotNull(message = "Elige un método de pago")
    private Long paymentMethodId;
}
