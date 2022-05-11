package ojt.project.service;

import ojt.project.dto.Order;
import ojt.project.dto.Product;
import ojt.project.dto.User;

import java.util.ArrayList;
import java.util.HashMap;


public interface OrderService {
    void insertOrder(Order order) throws Exception;

    ArrayList<HashMap<String, Product>> getOrderList(String id) throws Exception;
}
