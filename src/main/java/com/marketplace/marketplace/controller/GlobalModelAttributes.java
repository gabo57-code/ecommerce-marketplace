package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.security.Principal;

/** Datos disponibles en todas las páginas: "cartCount" (unidades en el carrito) e "isSeller". */
@ControllerAdvice
@RequiredArgsConstructor
public class GlobalModelAttributes {

    private final CartService cartService;

    @ModelAttribute("cartCount")
    public int cartCount(Principal principal) {
        if (principal == null) {
            return 0;
        }
        return cartService.countUnits(principal.getName());
    }

    @ModelAttribute("isSeller")
    public boolean isSeller(Authentication auth) {
        return auth != null && auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_SELLER"));
    }
}
