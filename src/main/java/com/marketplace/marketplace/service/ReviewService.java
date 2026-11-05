package com.marketplace.marketplace.service;

import com.marketplace.marketplace.model.Product;
import com.marketplace.marketplace.model.Review;
import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.OrderItemRepository;
import com.marketplace.marketplace.repository.ProductRepository;
import com.marketplace.marketplace.repository.ReviewRepository;
import com.marketplace.marketplace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final OrderItemRepository orderItemRepository;

    /** Crea la reseña, o la actualiza si el comprador ya había opinado sobre ese producto. */
    @Transactional
    public void saveReview(String email, Long productId, int rating, String comment) {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("La calificación debe ser de 1 a 5 estrellas");
        }

        String text = (comment == null) ? null : comment.trim();
        if (text != null && text.length() > 500) {
            throw new IllegalArgumentException("El comentario no puede pasar de 500 caracteres");
        }
        if (text != null && text.isEmpty()) {
            text = null;
        }

        Product product = productRepository.findByIdAndActiveTrue(productId)
                .orElseThrow(() -> new IllegalArgumentException("Producto no encontrado"));

        if (!orderItemRepository.existsByOrder_Buyer_EmailAndProduct_Id(email, productId)) {
            throw new IllegalArgumentException("Solo puedes opinar sobre productos que ya compraste");
        }

        User buyer = userRepository.findByEmail(email).orElseThrow();

        Review review = reviewRepository.findByProduct_IdAndBuyer_Email(productId, email)
                .orElseGet(Review::new);
        review.setProduct(product);
        review.setBuyer(buyer);
        review.setRating(rating);
        review.setComment(text);
        reviewRepository.save(review);
    }
}
