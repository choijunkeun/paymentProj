package ojt.project.service;

import ojt.project.dao.ProductDAO;
import ojt.project.dto.Product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductDAO productDAO;


    @Override
    public ArrayList<HashMap<String,Product>> getProductList() throws Exception {
        return productDAO.getProductList();
    }

    @Override
    public Product getProductDetail(int product_number) throws Exception {
        return productDAO.getProductDetail(product_number);
    }

    @Override
    public void subtractProductAmount(int order_amount, int product_number) throws Exception {
        productDAO.subtractProductAmount(order_amount, product_number);
    }
}
