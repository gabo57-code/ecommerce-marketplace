package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.UserRepository;
import com.marketplace.marketplace.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;
    private final UserRepository userRepository;

    @GetMapping
    public String view(Principal principal, Model model) {
        User user = userRepository.findByEmail(principal.getName()).orElseThrow();
        model.addAttribute("user", user);
        model.addAttribute("cart", cartService.getSummary(principal.getName()));
        return "shop/cart";
    }

    @PostMapping("/add")
    public String add(@RequestParam("productId") Long productId,
                      @RequestParam(name = "quantity", defaultValue = "1") int quantity,
                      Principal principal, RedirectAttributes ra) {
        try {
            cartService.addItem(principal.getName(), productId, quantity);
            ra.addFlashAttribute("success", "Producto agregado al carrito");
            return "redirect:/cart";
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:/shop/product/" + productId;
        }
    }

    @PostMapping("/update")
    public String update(@RequestParam("itemId") Long itemId,
                         @RequestParam("quantity") int quantity,
                         Principal principal, RedirectAttributes ra) {
        try {
            cartService.updateQuantity(principal.getName(), itemId, quantity);
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart";
    }

    @PostMapping("/remove/{itemId}")
    public String remove(@PathVariable("itemId") Long itemId, Principal principal, RedirectAttributes ra) {
        try {
            cartService.removeItem(principal.getName(), itemId);
            ra.addFlashAttribute("success", "Producto quitado del carrito");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart";
    }
}
