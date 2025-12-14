package com.ecom.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items = new LinkedHashMap<>();
    private static final double GST_RATE = 0.18; // 18%

    public void addItem(Item item, int qty) {
        if (qty <= 0) return;

        CartItem existing = items.get(item.getId());
        if (existing == null) {
            items.put(item.getId(), new CartItem(item, qty));
        } else {
            existing.setQuantity(existing.getQuantity() + qty);
        }
    }

    public void decreaseQuantity(int id) {
        CartItem existing = items.get(id);
        if (existing != null) {
            int newQty = existing.getQuantity() - 1;
            if (newQty <= 0) {
                // If quantity becomes 0 or less, remove item completely
                items.remove(id);
            } else {
                existing.setQuantity(newQty);
            }
        }
    }

    public void removeItem(int id) {
        items.remove(id);
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public double getSubtotal() {
        double sum = 0;
        for (CartItem ci : items.values()) {
            sum += ci.getLineTotal();
        }
        return sum;
    }

    public double getGST() {
        return getSubtotal() * GST_RATE;
    }

    public double getGrandTotal() {
        return getSubtotal() + getGST();
    }

    public void clear() {
        items.clear();
    }
}