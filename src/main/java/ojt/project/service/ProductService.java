package ojt.project.service;

import ojt.project.dto.Product;

import java.util.ArrayList;
import java.util.HashMap;

public interface ProductService {
    ArrayList<HashMap<String,Product>> getProductList() throws Exception;

    Product getProductDetail(int product_number) throws Exception;

    void subtractProductAmount(int order_amount, int product_number) throws Exception;
}
