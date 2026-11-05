package com.marketplace.marketplace.service;

import com.marketplace.marketplace.dto.RegisterForm;
import com.marketplace.marketplace.model.Cart;
import com.marketplace.marketplace.model.Role;
import com.marketplace.marketplace.model.Store;
import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.CartRepository;
import com.marketplace.marketplace.repository.RoleRepository;
import com.marketplace.marketplace.repository.StoreRepository;
import com.marketplace.marketplace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final StoreRepository storeRepository;
    private final CartRepository cartRepository;
    private final PasswordEncoder passwordEncoder;

    /** Toda cuenta nueva es de comprador; para vender se usa becomeSeller(). */
    @Transactional
    public void register(RegisterForm form) {
        String email = form.getEmail().trim().toLowerCase();

        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Ya existe una cuenta con ese correo");
        }

        Role role = roleRepository.findByName("BUYER")
                .orElseThrow(() -> new IllegalStateException(
                        "No existe el rol BUYER. ¿Ejecutaste schema.sql?"));

        User user = new User();
        user.setFullName(form.getFullName().trim());
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(form.getPassword()));
        user.setRole(role);
        user.setEnabled(true);
        userRepository.save(user);

        Cart cart = new Cart();
        cart.setUser(user);
        cartRepository.save(cart);
    }

    /** Abre la tienda de un usuario que ya tiene cuenta ("Quiero vender"). */
    @Transactional
    public void becomeSeller(String email, String storeName) {
        User user = userRepository.findByEmail(email).orElseThrow();

        if (storeRepository.existsBySellerEmail(email)) {
            throw new IllegalArgumentException("Ya tienes una tienda abierta");
        }

        Store store = new Store();
        store.setSeller(user);
        store.setName(storeName.trim());
        storeRepository.save(store);
    }
}
