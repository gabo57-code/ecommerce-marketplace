package com.marketplace.marketplace.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterForm {

    @NotBlank(message = "Escribe tu nombre completo")
    @Size(max = 100, message = "Máximo 100 caracteres")
    private String fullName;

    @NotBlank(message = "Escribe tu correo")
    @Email(message = "Correo no válido")
    @Size(max = 120)
    private String email;

    @NotBlank(message = "Escribe una contraseña")
    @Size(min = 6, max = 50, message = "La contraseña debe tener entre 6 y 50 caracteres")
    private String password;
}
