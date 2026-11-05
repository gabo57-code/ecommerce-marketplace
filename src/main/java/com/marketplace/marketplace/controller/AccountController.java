package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.dto.BecomeSellerForm;
import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.StoreRepository;
import com.marketplace.marketplace.repository.UserRepository;
import com.marketplace.marketplace.service.CustomUserDetailsService;
import com.marketplace.marketplace.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

/** "Quiero vender": convierte a un comprador en vendedor sin crear otra cuenta. */
@Controller
@RequestMapping("/account")
@RequiredArgsConstructor
public class AccountController {

    private final UserService userService;
    private final UserRepository userRepository;
    private final StoreRepository storeRepository;
    private final CustomUserDetailsService userDetailsService;
    private final SecurityContextRepository securityContextRepository = new HttpSessionSecurityContextRepository();

    @GetMapping("/sell")
    public String sellForm(Principal principal, Model model) {
        if (storeRepository.existsBySellerEmail(principal.getName())) {
            return "redirect:/seller/dashboard";
        }
        User user = currentUser(principal);

        String suggestion = "Tienda de " + user.getFullName();
        BecomeSellerForm form = new BecomeSellerForm();
        form.setStoreName(suggestion.length() > 100 ? suggestion.substring(0, 100) : suggestion);

        model.addAttribute("user", user);
        model.addAttribute("form", form);
        return "account/become-seller";
    }

    @PostMapping("/sell")
    public String becomeSeller(@Valid @ModelAttribute("form") BecomeSellerForm form,
                               BindingResult result,
                               Principal principal, Model model, RedirectAttributes ra,
                               HttpServletRequest request, HttpServletResponse response) {
        if (!result.hasErrors()) {
            try {
                userService.becomeSeller(principal.getName(), form.getStoreName());
                refreshAuthentication(principal.getName(), request, response);
                ra.addFlashAttribute("success", "¡Tu tienda está lista! Ya puedes publicar tus productos");
                return "redirect:/seller/dashboard";
            } catch (IllegalArgumentException e) {
                result.reject("seller.invalid", e.getMessage());
            }
        }
        model.addAttribute("user", currentUser(principal));
        return "account/become-seller";
    }

    /** Recarga los permisos de la sesión actual para que incluyan ROLE_SELLER ya mismo. */
    private void refreshAuthentication(String email, HttpServletRequest request, HttpServletResponse response) {
        UserDetails details = userDetailsService.loadUserByUsername(email);
        UsernamePasswordAuthenticationToken auth =
                UsernamePasswordAuthenticationToken.authenticated(details, null, details.getAuthorities());

        SecurityContext context = SecurityContextHolder.createEmptyContext();
        context.setAuthentication(auth);
        SecurityContextHolder.setContext(context);
        securityContextRepository.saveContext(context, request, response);
    }

    private User currentUser(Principal principal) {
        return userRepository.findByEmail(principal.getName()).orElseThrow();
    }
}
