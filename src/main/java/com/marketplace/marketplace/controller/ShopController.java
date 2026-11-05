package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.model.Product;
import com.marketplace.marketplace.model.Review;
import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.CategoryRepository;
import com.marketplace.marketplace.repository.OrderItemRepository;
import com.marketplace.marketplace.repository.ProductRepository;
import com.marketplace.marketplace.repository.ReviewRepository;
import com.marketplace.marketplace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.util.UriComponentsBuilder;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/shop")
@RequiredArgsConstructor
public class ShopController {

    /** Productos por página (4 columnas x 6 filas en escritorio). */
    private static final int PAGE_SIZE = 24;

    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final ReviewRepository reviewRepository;
    private final OrderItemRepository orderItemRepository;

    // ---------- Catálogo (paginado) ----------
    @GetMapping
    public String home(@RequestParam(name = "q", required = false) String q,
                       @RequestParam(name = "category", required = false) Long category,
                       @RequestParam(name = "sort", required = false, defaultValue = "new") String sort,
                       @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                       Principal principal, Model model) {

        String query = (q == null) ? "" : q.trim();
        String sortKey = ("price_asc".equals(sort) || "price_desc".equals(sort)) ? sort : "new";
        Long categoryId = (category == null) ? 0L : category;

        int pageIndex = Math.max(page, 1) - 1;
        Page<Product> result = productRepository.search(
                categoryId, query, PageRequest.of(pageIndex, PAGE_SIZE, sortFor(sortKey)));

        // Si piden una página que ya no existe (por ejemplo, tras cambiar un filtro), vamos a la última
        if (result.getTotalPages() > 0 && pageIndex >= result.getTotalPages()) {
            pageIndex = result.getTotalPages() - 1;
            result = productRepository.search(
                    categoryId, query, PageRequest.of(pageIndex, PAGE_SIZE, sortFor(sortKey)));
        }

        int totalPages = result.getTotalPages();
        long totalItems = result.getTotalElements();
        long firstItem = (totalItems == 0) ? 0 : (long) pageIndex * PAGE_SIZE + 1;
        long lastItem = (long) pageIndex * PAGE_SIZE + result.getNumberOfElements();

        model.addAttribute("user", currentUser(principal));
        model.addAttribute("products", result.getContent());
        model.addAttribute("categories", categoryRepository.findAll());
        model.addAttribute("q", query);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("sort", sortKey);

        // Datos de la paginación
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", pageIndex + 1);
        model.addAttribute("firstItem", firstItem);
        model.addAttribute("lastItem", lastItem);
        model.addAttribute("pageNumbers", pageNumbers(pageIndex + 1, totalPages));
        model.addAttribute("pagePrefix", pagePrefix(query, category, sortKey));
        return "shop/home";
    }

    // ---------- Detalle de un producto (con reseñas) ----------
    @GetMapping("/product/{id}")
    public String detail(@PathVariable("id") Long id, Principal principal, Model model) {
        Product product = productRepository.findByIdAndActiveTrue(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Producto no encontrado"));

        List<Review> reviews = reviewRepository.findByProduct_IdOrderByCreatedAtDesc(id);
        Review mine = reviewRepository.findByProduct_IdAndBuyer_Email(id, principal.getName()).orElse(null);

        model.addAttribute("user", currentUser(principal));
        model.addAttribute("product", product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("reviewCount", reviews.size());
        model.addAttribute("avgRating", reviewRepository.averageRating(id));
        model.addAttribute("myReview", mine);
        model.addAttribute("canReview",
                orderItemRepository.existsByOrder_Buyer_EmailAndProduct_Id(principal.getName(), id));
        return "shop/product-detail";
    }

    // ---------- Auxiliares ----------

    /** Orden del catálogo. El "id" desempata para que las páginas sean estables. */
    private Sort sortFor(String sortKey) {
        return switch (sortKey) {
            case "price_asc" -> Sort.by(Sort.Order.asc("price"), Sort.Order.desc("id"));
            case "price_desc" -> Sort.by(Sort.Order.desc("price"), Sort.Order.desc("id"));
            default -> Sort.by(Sort.Order.desc("createdAt"), Sort.Order.desc("id"));
        };
    }

    /**
     * Números de página a mostrar: siempre la primera y la última, y las cercanas a la actual.
     * El valor -1 representa los puntos suspensivos "…".
     */
    private List<Integer> pageNumbers(int current, int total) {
        List<Integer> out = new ArrayList<>();
        int previous = 0;
        for (int i = 1; i <= total; i++) {
            boolean show = i == 1 || i == total || Math.abs(i - current) <= 2;
            if (show) {
                if (i - previous > 1) {
                    out.add(-1);
                }
                out.add(i);
                previous = i;
            }
        }
        return out;
    }

    /** Dirección base de los enlaces de página, conservando búsqueda, categoría y orden. */
    private String pagePrefix(String query, Long category, String sortKey) {
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("/shop");
        if (!query.isEmpty()) {
            builder.queryParam("q", query);
        }
        if (category != null) {
            builder.queryParam("category", category);
        }
        if (!"new".equals(sortKey)) {
            builder.queryParam("sort", sortKey);
        }
        String base = builder.build().encode().toUriString();
        return base + (base.contains("?") ? "&" : "?") + "page=";
    }

    private User currentUser(Principal principal) {
        return userRepository.findByEmail(principal.getName()).orElseThrow();
    }
}
