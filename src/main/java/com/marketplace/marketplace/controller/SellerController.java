package com.marketplace.marketplace.controller;

import com.marketplace.marketplace.dto.ProductForm;
import com.marketplace.marketplace.model.OrderItem;
import com.marketplace.marketplace.model.Product;
import com.marketplace.marketplace.model.Store;
import com.marketplace.marketplace.repository.CategoryRepository;
import com.marketplace.marketplace.repository.OrderItemRepository;
import com.marketplace.marketplace.repository.StoreRepository;
import com.marketplace.marketplace.service.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/seller")
@RequiredArgsConstructor
public class SellerController {

    private final StoreRepository storeRepository;
    private final CategoryRepository categoryRepository;
    private final OrderItemRepository orderItemRepository;
    private final ProductService productService;

    // ---------- Panel principal ----------
    @GetMapping("/dashboard")
    public String dashboard(Principal principal, Model model) {
        List<Product> products = productService.listActive(principal.getName());
        int totalUnits = products.stream().mapToInt(Product::getStock).sum();
        long lowStock = products.stream().filter(p -> p.getStock() <= 5).count();

        model.addAttribute("store", currentStore(principal));
        model.addAttribute("products", products);
        model.addAttribute("totalProducts", products.size());
        model.addAttribute("totalUnits", totalUnits);
        model.addAttribute("lowStock", lowStock);
        return "seller/dashboard";
    }

    // ---------- Mis ventas ----------
    @GetMapping("/sales")
    public String sales(Principal principal, Model model) {
        List<OrderItem> sales = orderItemRepository.findByProduct_Store_Seller_Email(
                principal.getName(), Sort.by(Sort.Direction.DESC, "order.createdAt", "id"));

        BigDecimal revenue = sales.stream()
                .map(i -> i.getUnitPrice().multiply(BigDecimal.valueOf(i.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        int unitsSold = sales.stream().mapToInt(OrderItem::getQuantity).sum();
        long ordersCount = sales.stream().map(i -> i.getOrder().getId()).distinct().count();

        model.addAttribute("store", currentStore(principal));
        model.addAttribute("sales", sales);
        model.addAttribute("revenue", revenue);
        model.addAttribute("unitsSold", unitsSold);
        model.addAttribute("ordersCount", ordersCount);
        return "seller/sales";
    }

    // ---------- Crear ----------
    @GetMapping("/products/new")
    public String newProduct(Principal principal, Model model) {
        model.addAttribute("form", new ProductForm());
        return formView(model, principal, false, null);
    }

    @PostMapping("/products")
    public String create(@Valid @ModelAttribute("form") ProductForm form,
                         BindingResult result,
                         @RequestParam(value = "image", required = false) MultipartFile image,
                         Principal principal, Model model, RedirectAttributes ra) {
        if (!result.hasErrors()) {
            try {
                productService.create(principal.getName(), form, image);
                ra.addFlashAttribute("success", "Producto publicado correctamente");
                return "redirect:/seller/dashboard";
            } catch (IllegalArgumentException e) {
                result.reject("product.invalid", e.getMessage());
            }
        }
        return formView(model, principal, false, null);
    }

    // ---------- Editar ----------
    @GetMapping("/products/{id}/edit")
    public String editProduct(@PathVariable("id") Long id, Principal principal, Model model) {
        Product p = productService.getOwned(principal.getName(), id);

        ProductForm form = new ProductForm();
        form.setName(p.getName());
        form.setDescription(p.getDescription());
        form.setPrice(p.getPrice());
        form.setStock(p.getStock());
        form.setCategoryId(p.getCategory().getId());

        model.addAttribute("form", form);
        return formView(model, principal, true, p);
    }

    @PostMapping("/products/{id}")
    public String update(@PathVariable("id") Long id,
                         @Valid @ModelAttribute("form") ProductForm form,
                         BindingResult result,
                         @RequestParam(value = "image", required = false) MultipartFile image,
                         Principal principal, Model model, RedirectAttributes ra) {
        if (!result.hasErrors()) {
            try {
                productService.update(principal.getName(), id, form, image);
                ra.addFlashAttribute("success", "Producto actualizado correctamente");
                return "redirect:/seller/dashboard";
            } catch (IllegalArgumentException e) {
                result.reject("product.invalid", e.getMessage());
            }
        }
        return formView(model, principal, true, productService.getOwned(principal.getName(), id));
    }

    // ---------- Eliminar ----------
    @PostMapping("/products/{id}/delete")
    public String delete(@PathVariable("id") Long id, Principal principal, RedirectAttributes ra) {
        productService.delete(principal.getName(), id);
        ra.addFlashAttribute("success", "Producto eliminado");
        return "redirect:/seller/dashboard";
    }

    // ---------- Auxiliares ----------
    private Store currentStore(Principal principal) {
        return storeRepository.findBySellerEmail(principal.getName())
                .orElseThrow(() -> new IllegalStateException("El vendedor no tiene tienda"));
    }

    private String formView(Model model, Principal principal, boolean editing, Product product) {
        model.addAttribute("store", currentStore(principal));
        model.addAttribute("categories", categoryRepository.findAll());
        model.addAttribute("editing", editing);
        if (product != null) {
            model.addAttribute("productId", product.getId());
            model.addAttribute("currentImage",
                    product.getImages().isEmpty() ? null : product.getImages().get(0).getImageUrl());
        }
        return "seller/product-form";
    }
}
