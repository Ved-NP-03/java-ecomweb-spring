package com.ecom.data;

import java.util.ArrayList;
import java.util.List;

import com.ecom.model.Item;

public class ProductData {

    private static List<Item> products = new ArrayList<>();

    static {
        products.add(new Item(1, "Pen", 10.0));
        products.add(new Item(2, "Notebook", 50.0));
        products.add(new Item(3, "Pencil", 5.0));
        products.add(new Item(4, "Eraser", 3.0));
        products.add(new Item(5, "Bag", 500.0));
        products.add(new Item(6, "Ruler", 15.0));
        products.add(new Item(7, "Marker", 25.0));
        products.add(new Item(8, "Stapler", 80.0));
        
    }

    public static List<Item> getAllProducts() {
        return products;
    }

    public static Item getById(int id) {
        for (Item item : products) {
            if (item.getId() == id) {
                return item;
            }
        }
        return null;
    }
}