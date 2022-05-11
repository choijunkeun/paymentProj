package ojt.project.dao;


import ojt.project.dto.Order;
import ojt.project.dto.Product;
import ojt.project.dto.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
@Mapper
public interface OrderDAO {
    void insertOrder(Order order) throws Exception;

    ArrayList<HashMap<String, Product>> getOrderList(String id) throws Exception;
}
