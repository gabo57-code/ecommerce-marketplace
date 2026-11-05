package com.marketplace.marketplace.service;

import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.StoreRepository;
import com.marketplace.marketplace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;
    private final StoreRepository storeRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("No existe el usuario: " + email));

        // Todos pueden comprar; quien tiene tienda también puede vender
        List<String> roles = new ArrayList<>();
        roles.add("BUYER");
        if (storeRepository.existsBySellerEmail(user.getEmail())) {
            roles.add("SELLER");
        }

        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail())
                .password(user.getPassword())
                .roles(roles.toArray(String[]::new))
                .disabled(!user.getEnabled())
                .build();
    }
}