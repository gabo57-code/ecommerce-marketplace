package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.dto.CartSummary;
import com.marketplace.marketplace.dto.CheckoutForm;
import com.marketplace.marketplace.model.PaymentMethod;
import com.marketplace.marketplace.model.PurchaseOrder;
import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.AddressRepository;
import com.marketplace.marketplace.repository.PaymentMethodRepository;
import com.marketplace.marketplace.repository.PaymentRepository;
import com.marketplace.marketplace.repository.PurchaseOrderRepository;
import com.marketplace.marketplace.repository.UserRepository;
import com.marketplace.marketplace.service.CartService;
import com.marketplace.marketplace.service.CheckoutService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/checkout")
@RequiredArgsConstructor
public class CheckoutController {

    private final CartService cartService;
    private final CheckoutService checkoutService;
    private final UserRepository userRepository;
    private final AddressRepository addressRepository;
    private final PaymentMethodRepository paymentMethodRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final PaymentRepository paymentRepository;

    // ---------- Pantalla de pago ----------
    @GetMapping
    public String checkout(Principal principal, Model model) {
        CartSummary cart = cartService.getSummary(principal.getName());
        if (cart.getLines().isEmpty()) {
            return "redirect:/cart";
        }

        CheckoutForm form = new CheckoutForm();
        // Rellena con la última dirección usada
        addressRepository.findByUserEmailOrderByIdDesc(principal.getName()).stream().findFirst()
                .ifPresent(a -> {
                    form.setStreet(a.getStreet());
                    form.setCity(a.getCity());
                    form.setDepartment(a.getDepartment());
                    form.setPostalCode(a.getPostalCode());
                });
        // Método de pago por defecto: el primero
        List<PaymentMethod> methods = paymentMethodRepository.findAll();
        if (!methods.isEmpty()) {
            form.setPaymentMethodId(methods.get(0).getId());
        }

        model.addAttribute("form", form);
        prepare(model, principal);
        return "shop/checkout";
    }

    // ---------- Confirmar compra ----------
    @PostMapping
    public String place(@Valid @ModelAttribute("form") CheckoutForm form,
                        BindingResult result, Principal principal, Model model) {
        if (!result.hasErrors()) {
            try {
                PurchaseOrder order = checkoutService.placeOrder(principal.getName(), form);
                return "redirect:/checkout/success/" + order.getId();
            } catch (IllegalArgumentException e) {
                result.reject("checkout.error", e.getMessage());
            }
        }
        prepare(model, principal);
        return "shop/checkout";
    }

    // ---------- Compra exitosa ----------
    @GetMapping("/success/{id}")
    public String success(@PathVariable("id") Long id, Principal principal, Model model) {
        PurchaseOrder order = purchaseOrderRepository.findByIdAndBuyerEmail(id, principal.getName())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Pedido no encontrado"));

        model.addAttribute("user", currentUser(principal));
        model.addAttribute("order", order);
        model.addAttribute("payment", paymentRepository.findByOrder_Id(id).orElse(null));
        return "shop/checkout-success";
    }

    private void prepare(Model model, Principal principal) {
        model.addAttribute("user", currentUser(principal));
        model.addAttribute("cart", cartService.getSummary(principal.getName()));
        model.addAttribute("paymentMethods", paymentMethodRepository.findAll());
    }

    private User currentUser(Principal principal) {
        return userRepository.findByEmail(principal.getName()).orElseThrow();
    }
}
