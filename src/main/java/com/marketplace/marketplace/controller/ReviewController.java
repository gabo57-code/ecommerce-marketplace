package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @PostMapping("/shop/product/{id}/review")
    public String save(@PathVariable("id") Long id,
                       @RequestParam("rating") int rating,
                       @RequestParam(name = "comment", required = false) String comment,
                       Principal principal, RedirectAttributes ra) {
        try {
            reviewService.saveReview(principal.getName(), id, rating, comment);
            ra.addFlashAttribute("success", "¡Gracias por tu opinión!");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/shop/product/" + id + "#reviews";
    }
}
