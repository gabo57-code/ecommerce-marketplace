package com.marketplace.marketplace.service;

import com.marketplace.marketplace.dto.ProductForm;
import com.marketplace.marketplace.model.Category;
import com.marketplace.marketplace.model.Product;
import com.marketplace.marketplace.model.ProductImage;
import com.marketplace.marketplace.model.Store;
import com.marketplace.marketplace.repository.CategoryRepository;
import com.marketplace.marketplace.repository.ProductRepository;
import com.marketplace.marketplace.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final StoreRepository storeRepository;
    private final FileStorageService fileStorageService;

    @Transactional(readOnly = true)
    public List<Product> listActive(String sellerEmail) {
        return productRepository.findByStoreSellerEmailAndActiveTrueOrderByCreatedAtDesc(sellerEmail);
    }

    @Transactional(readOnly = true)
    public Product getOwned(String sellerEmail, Long id) {
        return productRepository.findByIdAndStoreSellerEmailAndActiveTrue(id, sellerEmail)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Producto no encontrado"));
    }

    @Transactional
    public Product create(String sellerEmail, ProductForm form, MultipartFile image) {
        Store store = storeRepository.findBySellerEmail(sellerEmail)
                .orElseThrow(() -> new IllegalStateException("El vendedor no tiene tienda"));

        Product product = new Product();
        product.setStore(store);
        apply(product, form);
        attachImage(product, image);
        return productRepository.save(product);
    }

    @Transactional
    public Product update(String sellerEmail, Long id, ProductForm form, MultipartFile image) {
        Product product = getOwned(sellerEmail, id);
        apply(product, form);
        attachImage(product, image);
        return productRepository.save(product);
    }

    /** "Eliminar" = borrado lógico, para no romper pedidos antiguos. */
    @Transactional
    public void delete(String sellerEmail, Long id) {
        Product product = getOwned(sellerEmail, id);
        product.setActive(false);
        productRepository.save(product);
    }

    private void apply(Product product, ProductForm form) {
        Category category = categoryRepository.findById(form.getCategoryId())
                .orElseThrow(() -> new IllegalArgumentException("Categoría no válida"));
        product.setName(form.getName().trim());
        product.setDescription(form.getDescription() == null ? null : form.getDescription().trim());
        product.setPrice(form.getPrice());
        product.setStock(form.getStock());
        product.setCategory(category);
    }

    private void attachImage(Product product, MultipartFile image) {
        if (image == null || image.isEmpty()) {
            return; // no subió imagen nueva: se conserva la actual
        }
        String url = fileStorageService.store(image);
        product.getImages().clear();
        ProductImage img = new ProductImage();
        img.setProduct(product);
        img.setImageUrl(url);
        product.getImages().add(img);
    }
}
