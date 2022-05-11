package ojt.project.controller;

import ojt.project.dto.Product;
import ojt.project.dto.User;
import ojt.project.service.OrderService;
import ojt.project.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class MainController {

    @Autowired
    UserService userService;

    @Autowired
    OrderService orderService;

    final int FAIL = 0;



    @GetMapping("/")
    public String main() {
        System.out.println("main() join");
        return "main/main";
    }

    @GetMapping("/loginForm")
    public String login() {
        return "main/login";
    }

    @GetMapping("/joinForm")
    public String joinForm() {
        return "main/join";
    }

    //회원가입 기능
    @PostMapping("/join")
    public String join(@Valid User user, BindingResult result, Model model) throws Exception {


        if (!result.hasErrors()) {
            int rowCnt = userService.insertUser(user);
            System.out.println("에러 없으면 실행");
            if (rowCnt != FAIL) {
                return "main/joinSuccess";
            } else {
                String error = "중복된 아이디가 존재합니다";
                model.addAttribute("error", error);
            }
        }
        return "main/join";
    }

    //로그인 기능
    @PostMapping("/login")
    public String login(String id, String password, String toURL, boolean remeberId, Model model, HttpServletRequest request, HttpServletResponse response) {
        System.out.println("login() JOIN");
        try {
            // 1. id, password 확인
            if(!loginCheck(id, password)) {
                // 2-1 일치하지 않으면, loginForm으로 이동하고, 메세지 출력
                String msg = URLEncoder.encode("아이디 또는 패스워드가 일치하지 않습니다.", "utf-8");
                return "redirect:/loginForm?msg=" + msg;
            }

            // 2-2 일치하면, 세션객체 얻어서 세션객체에 id저장
            HttpSession session = request.getSession();
            session.setAttribute("id", id);

            //id저장 체크되어있으면(true) 쿠키 생성, 응답에 저장
            if(remeberId) {
                Cookie cookie = new Cookie("id", id);
                response.addCookie(cookie);
            } else {
                //id저장 체크안되어있으면 쿠키생성, 수명 0 으로 저장해서 응답에 저장
                Cookie cookie = new Cookie("id", id);
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        //로그인 했을 때 toURL이 공백이면 홈으로, 있으면 해당페이지로 이동
        toURL = toURL==null || toURL.equals("") ? "/" : toURL;
        return "redirect:" + toURL;
    }

    //로그인 유효성 체크
    private boolean loginCheck(String id, String password) throws Exception{
        //db에서 아이디를 조회한다.
        System.out.println("logincheck() JOIN");
        User user = userService.selectUser(id);
        if(user==null) return false;
        return user.getPassword().equals(password);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    //상품 페이지로 넘어감
    @GetMapping("/shop")
    public String shop()  {
        return "main/shopForm";
    }

    //마이페이지
    @GetMapping("/myPage")
    public String mypage() {
        return "main/myPage";
    }

    //구매목록 마이페이지에 출력
    @ResponseBody
    @GetMapping("/myPage/order")
    public ArrayList<HashMap<String, Product>> orderList(HttpSession session) {
        ArrayList<HashMap<String, Product>> orderList = new ArrayList<>();
        try {
            String id = (String) session.getAttribute("id");
            orderList = orderService.getOrderList(id);
            System.out.println(orderList);


        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }
}
