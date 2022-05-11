package ojt.project.dao;

import ojt.project.dto.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;



@Repository
@Mapper
public interface ProductDAO {
    ArrayList<HashMap<String,Product>> getProductList() throws Exception;

    Product getProductDetail(int product_number) throws Exception;

    void subtractProductAmount(@Param("order_amount") int order_amount, @Param("product_number")int product_number)throws Exception;
}
