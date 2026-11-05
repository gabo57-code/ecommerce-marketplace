package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.PurchaseOrderRepository;
import com.marketplace.marketplace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

/** "Mis compras" del comprador. */
@Controller
@RequestMapping("/shop/orders")
@RequiredArgsConstructor
public class OrderController {

    private final PurchaseOrderRepository purchaseOrderRepository;
    private final UserRepository userRepository;

    @GetMapping
    public String myOrders(Principal principal, Model model) {
        User user = userRepository.findByEmail(principal.getName()).orElseThrow();
        model.addAttribute("user", user);
        model.addAttribute("orders", purchaseOrderRepository.findByBuyerEmailOrderByCreatedAtDesc(principal.getName()));
        return "shop/orders";
    }
}
