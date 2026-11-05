package com.marketplace.marketplace.service;

import com.marketplace.marketplace.dto.CartLine;
import com.marketplace.marketplace.dto.CartSummary;
import com.marketplace.marketplace.model.Cart;
import com.marketplace.marketplace.model.CartItem;
import com.marketplace.marketplace.model.Product;
import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.CartRepository;
import com.marketplace.marketplace.repository.ProductRepository;
import com.marketplace.marketplace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    /** Cantidad total de unidades en el carrito (para el contador de la barra superior). */
    @Transactional(readOnly = true)
    public int countUnits(String email) {
        return cartRepository.findByUserEmail(email)
                .map(c -> c.getItems().stream().mapToInt(CartItem::getQuantity).sum())
                .orElse(0);
    }

    @Transactional(readOnly = true)
    public CartSummary getSummary(String email) {
        List<CartLine> lines = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;
        int units = 0;

        Cart cart = cartRepository.findByUserEmail(email).orElse(null);
        if (cart != null) {
            List<CartItem> items = new ArrayList<>(cart.getItems());
            items.sort(Comparator.comparing(CartItem::getId));
            for (CartItem ci : items) {
                Product p = ci.getProduct();
                BigDecimal subtotal = p.getPrice().multiply(BigDecimal.valueOf(ci.getQuantity()));
                boolean available = Boolean.TRUE.equals(p.getActive()) && p.getStock() >= ci.getQuantity();
                lines.add(new CartLine(ci.getId(), p, ci.getQuantity(), subtotal, available));
                total = total.add(subtotal);
                units += ci.getQuantity();
            }
        }
        return new CartSummary(lines, total, units);
    }

    @Transactional
    public void addItem(String email, Long productId, int quantity) {
        if (quantity < 1) {
            quantity = 1;
        }
        Product product = productRepository.findByIdAndActiveTrue(productId)
                .orElseThrow(() -> new IllegalArgumentException("Ese producto ya no está disponible"));

        // Un vendedor no puede comprar sus propios productos
        if (product.getStore().getSeller().getEmail().equalsIgnoreCase(email)) {
            throw new IllegalArgumentException("No puedes comprar tus propios productos");
        }

        Cart cart = getOrCreateCart(email);
        CartItem item = cart.getItems().stream()
                .filter(ci -> ci.getProduct().getId().equals(productId))
                .findFirst()
                .orElse(null);

        int newQuantity = (item == null ? 0 : item.getQuantity()) + quantity;
        if (newQuantity > product.getStock()) {
            throw new IllegalArgumentException(
                    "Solo hay " + product.getStock() + " unidades disponibles de este producto");
        }

        if (item == null) {
            item = new CartItem();
            item.setCart(cart);
            item.setProduct(product);
            cart.getItems().add(item);
        }
        item.setQuantity(newQuantity);
        cartRepository.save(cart);
    }

    @Transactional
    public void updateQuantity(String email, Long itemId, int quantity) {
        Cart cart = cartRepository.findByUserEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Tu carrito está vacío"));
        CartItem item = findItem(cart, itemId);

        if (quantity <= 0) {
            cart.getItems().remove(item);
        } else {
            if (quantity > item.getProduct().getStock()) {
                throw new IllegalArgumentException(
                        "Solo hay " + item.getProduct().getStock() + " unidades disponibles de este producto");
            }
            item.setQuantity(quantity);
        }
        cartRepository.save(cart);
    }

    @Transactional
    public void removeItem(String email, Long itemId) {
        Cart cart = cartRepository.findByUserEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Tu carrito está vacío"));
        CartItem item = findItem(cart, itemId);
        cart.getItems().remove(item);
        cartRepository.save(cart);
    }

    private CartItem findItem(Cart cart, Long itemId) {
        return cart.getItems().stream()
                .filter(ci -> ci.getId().equals(itemId))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("Ese producto no está en tu carrito"));
    }

    private Cart getOrCreateCart(String email) {
        return cartRepository.findByUserEmail(email).orElseGet(() -> {
            User user = userRepository.findByEmail(email).orElseThrow();
            Cart cart = new Cart();
            cart.setUser(user);
            return cartRepository.save(cart);
        });
    }
}