package com.marketplace.marketplace.service;

import com.marketplace.marketplace.dto.CheckoutForm;
import com.marketplace.marketplace.model.Address;
import com.marketplace.marketplace.model.Cart;
import com.marketplace.marketplace.model.CartItem;
import com.marketplace.marketplace.model.OrderItem;
import com.marketplace.marketplace.model.OrderStatus;
import com.marketplace.marketplace.model.Payment;
import com.marketplace.marketplace.model.PaymentMethod;
import com.marketplace.marketplace.model.Product;
import com.marketplace.marketplace.model.PurchaseOrder;
import com.marketplace.marketplace.model.User;
import com.marketplace.marketplace.repository.AddressRepository;
import com.marketplace.marketplace.repository.CartRepository;
import com.marketplace.marketplace.repository.OrderStatusRepository;
import com.marketplace.marketplace.repository.PaymentMethodRepository;
import com.marketplace.marketplace.repository.PaymentRepository;
import com.marketplace.marketplace.repository.ProductRepository;
import com.marketplace.marketplace.repository.PurchaseOrderRepository;
import com.marketplace.marketplace.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CheckoutService {

    private final UserRepository userRepository;
    private final CartRepository cartRepository;
    private final AddressRepository addressRepository;
    private final OrderStatusRepository orderStatusRepository;
    private final PaymentMethodRepository paymentMethodRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final PaymentRepository paymentRepository;
    private final ProductRepository productRepository;

    /**
     * Convierte el carrito en un pedido:
     * valida stock -> crea dirección -> crea pedido y sus items -> registra el pago
     * -> descuenta stock -> vacía el carrito. Todo en UNA transacción:
     * si algo falla, no se guarda nada.
     */
    @Transactional
    public PurchaseOrder placeOrder(String email, CheckoutForm form) {
        User buyer = userRepository.findByEmail(email).orElseThrow();

        Cart cart = cartRepository.findByUserEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Tu carrito está vacío"));
        if (cart.getItems().isEmpty()) {
            throw new IllegalArgumentException("Tu carrito está vacío");
        }

        PaymentMethod method = paymentMethodRepository.findById(form.getPaymentMethodId())
                .orElseThrow(() -> new IllegalArgumentException("Método de pago no válido"));

        OrderStatus paid = orderStatusRepository.findByName("PAID")
                .orElseThrow(() -> new IllegalStateException("Falta el estado PAID. ¿Ejecutaste schema.sql?"));

        // 1) Validar stock y calcular total
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem ci : cart.getItems()) {
            Product p = ci.getProduct();
            if (!Boolean.TRUE.equals(p.getActive()) || p.getStock() < ci.getQuantity()) {
                throw new IllegalArgumentException(
                        "\"" + p.getName() + "\" ya no tiene stock suficiente. Ajusta las cantidades en tu carrito.");
            }
            total = total.add(p.getPrice().multiply(BigDecimal.valueOf(ci.getQuantity())));
        }

        // 2) Dirección de envío
        Address address = findOrCreateAddress(buyer, form);

        // 3) Pedido + items (guardamos el precio del momento) y descuento de stock
        PurchaseOrder order = new PurchaseOrder();
        order.setBuyer(buyer);
        order.setAddress(address);
        order.setStatus(paid);
        order.setTotal(total);

        for (CartItem ci : cart.getItems()) {
            Product p = ci.getProduct();

            OrderItem oi = new OrderItem();
            oi.setOrder(order);
            oi.setProduct(p);
            oi.setQuantity(ci.getQuantity());
            oi.setUnitPrice(p.getPrice());
            order.getItems().add(oi);

            p.setStock(p.getStock() - ci.getQuantity());
            productRepository.save(p);
        }
        purchaseOrderRepository.save(order);

        // 4) Pago (simulado: siempre aprobado)
        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setPaymentMethod(method);
        payment.setAmount(total);
        payment.setStatus("APPROVED");
        paymentRepository.save(payment);

        // 5) Vaciar el carrito
        cart.getItems().clear();
        cartRepository.save(cart);

        return order;
    }

    private Address findOrCreateAddress(User buyer, CheckoutForm form) {
        String street = form.getStreet().trim();
        String city = form.getCity().trim();
        String department = form.getDepartment().trim();

        List<Address> existing = addressRepository.findByUserEmailOrderByIdDesc(buyer.getEmail());
        for (Address a : existing) {
            if (a.getStreet().equalsIgnoreCase(street)
                    && a.getCity().equalsIgnoreCase(city)
                    && a.getDepartment().equalsIgnoreCase(department)) {
                return a;
            }
        }

        Address address = new Address();
        address.setUser(buyer);
        address.setStreet(street);
        address.setCity(city);
        address.setDepartment(department);
        String postal = form.getPostalCode();
        address.setPostalCode((postal == null || postal.isBlank()) ? null : postal.trim());
        address.setDefaultAddress(existing.isEmpty());
        return addressRepository.save(address);
    }
}
