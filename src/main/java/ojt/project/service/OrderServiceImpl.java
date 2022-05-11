package ojt.project.service;


import ojt.project.dao.OrderDAO;
import ojt.project.dto.Order;
import ojt.project.dto.Product;
import ojt.project.dto.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderDAO orderDAO;

    @Override
    public void insertOrder(Order order) throws Exception {
        orderDAO.insertOrder(order);
    }

    @Override
    public ArrayList<HashMap<String, Product>> getOrderList(String id) throws Exception {
        return orderDAO.getOrderList(id);
    }
}
