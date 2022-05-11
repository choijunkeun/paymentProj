package ojt.project.controller;


import ojt.project.dto.Order;
import ojt.project.dto.Product;
import ojt.project.dto.User;
import ojt.project.service.OrderService;
import ojt.project.service.ProductService;
import ojt.project.service.UserService;

import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;


@Controller
@RequestMapping("/shop")
public class ProductController {
    @Autowired
    ProductService productService;
    @Autowired
    UserService userService;
    @Autowired
    OrderService orderService;


    //쇼핑 페이지에 DB물품 리스트 뿌려주는 컨트롤러
    @ResponseBody
    @GetMapping("/product")
    public ArrayList<HashMap<String, Product>> productList() {
        ArrayList<HashMap<String, Product>> pList = new ArrayList<>();
        try {
            pList = productService.getProductList();
            System.out.println("pList = " + pList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pList;
    }

    //상품 클릭 시 해당 상품 구매페이지로 가는 컨트롤러
    @GetMapping("/product/{product_number}")
    public String productDetail(@PathVariable int product_number, Model model) {
        try {
            Product product = productService.getProductDetail(product_number);
            model.addAttribute("product", product);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "main/productForm";
    }

    //productForm에서 구매하기 누르면 제품명, 구매수량, 구매가격을 받아오고 세션에서 구매자 정보 받아오는 컨트롤러(주문서 작성페이지)
    @GetMapping("/product/order")
    public String order(int product_number, int amount, int sum, HttpSession session, HttpServletResponse response, Model model) {
        System.out.println("product_number = " + product_number);
        System.out.println("amount = " + amount);
        System.out.println("sum = " + sum);

        try {
            //세션에 저장된 아이디 가져오기
            String id = (String) session.getAttribute("id");

            //로그인 유효성 검사
            if (id == null || "".equals(id)) {
                System.out.println("if문");
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('로그인이 필요한 서비스입니다.'); </script>");
                out.flush();
                return "main/login";
            }
            User user = userService.selectUser(id);
            System.out.println("user = " + user);


            //가져온 상품번호로 상품정보 불러오기
            Product product = productService.getProductDetail(product_number);

            model.addAttribute("user", user);
            model.addAttribute("product", product);
            model.addAttribute("amount", amount);
            model.addAttribute("sum", sum);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "main/orderForm";
    }

    @ResponseBody
    @PostMapping("/product/order/buy")
    public HashMap<String, Object> buy(String id, String req_msg, String req_msg_direct, int product_number, int order_amount, int order_price) {
        HashMap<String, Object> map = new HashMap<>();
        try {

            //id 로 유저 정보 불러와서 주소 받아오기
            User user = userService.selectUser(id);
            //product_number로 상품 정보 받아오기
            Product product = productService.getProductDetail(product_number);
            //req_msg가 direct 이면 req_msg_direct를 request_message에 담기,
            //그렇지 않으면 req_msg를 request_message에 담기
            String request_message = null;
            if (req_msg.equals("direct")) {
                request_message = req_msg_direct;
                System.out.println("request_message = " + request_message);
            } else {
                request_message = req_msg;
                System.out.println("request_message = " + request_message);
            }

            Order order = new Order();
            order.setProduct_number(product_number);
            order.setId(id);
            order.setRequest_message(request_message);
            order.setOrder_amount(order_amount);
            order.setOrder_price(order_price);

            map.put("user", user);
            map.put("product", product);
            map.put("order", order);


//            //주문서에 유저정보, 상품정보, 주문개수, 주문가격, 배송메시지(req_msg or req_msg_direct) insert
//            orderService.insertOrder(order);
//
//            //상품재고에서 구매한 상품개수를 뺴준다
//            productService.subtractProductAmount(order_amount, product_number);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @ResponseBody
    @PostMapping("/product/order/buySuccess")
    public String buySuccess(String id, String order_amount, String order_price, String product_number, String request_message){
        Order order = new Order();
        try {
            order.setId(id);
            order.setOrder_amount(Integer.parseInt(order_amount));
            order.setOrder_price(Integer.parseInt(order_price));
            order.setProduct_number(Integer.parseInt(product_number));
            order.setRequest_message(request_message);
            //주문서에 유저정보, 상품정보, 주문개수, 주문가격, 배송메시지(req_msg or req_msg_direct) insert
            orderService.insertOrder(order);
            //상품재고에서 구매한 상품개수를 뺴준다
            productService.subtractProductAmount(Integer.parseInt(order_amount), Integer.parseInt(product_number));
        }catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }


//    @PostMapping("/test")
//    public String test(int id, String selbox, String selboxDirect) {
//        System.out.println("id = " + id);
//        System.out.println("selbox = " + selbox);
//        System.out.println("selboxDirect = " + selboxDirect);
//        return "main/orderForm";
//    }


//    //상품 구매시 구매한 만큼 남은수량 뺴주는 컨트롤러 (쿼리 합칠 예정)
//    @ResponseBody
//    @PostMapping("/shop/product/product_amount")
//    public String product_amount(int product_amount, int product_number) {
//        try {
//            productService.subtractProductAmount(product_amount, product_number);
//        }catch(Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }

}
