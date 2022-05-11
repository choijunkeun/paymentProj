<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Product Shop</title>
    <style>
        body {
            padding-top: 100px;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div>
            제품명 : ${product.getProduct_name()}<br>
            제품가격 : ${product.getProduct_price()}<br>
            남은수량 : ${product.getProduct_count()}<br>
        </div>
        <div>
            <form name="form" method="get" action="/shop/product/order">
                <input type="hidden" name="product_number" value="${product.getProduct_number()}">
                수량 :
<%--                <input type=hidden name="sell_price" value="${product.getProduct_price()}">--%>
                <input type="text" id="product_amount" name="amount" value="1" size="3" onchange="change();" readonly>
                <input type="button" value=" + " onclick="add();"><input type="button" value=" - " onclick="del();"><br>
                금액 : <input type="text" id="sum" name="sum" size="11" readonly>원
                <button type="submit" id="buyBtn" onclick="buy();">바로 구매하기</button>
            </form>
        </div>
<%--        <button type="button" id="buyBtn" onclick="iamport();">바로 구매하기</button>--%>
    </div>
</div>


</body>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script>
    <%--function buy() {--%>
    <%--    let id = '<%=(String)session.getAttribute("id")%>';--%>
    <%--    if (id == "null") {--%>
    <%--        alert("로그인이 필요한 서비스입니다.")--%>
    <%--        location.replace("/shop/product/${product.getProduct_number()}");--%>
    <%--    }--%>
    <%--}--%>

</script>

<script>
    //제품 가격
    let sell_price = ${product.getProduct_price()};
    //제품 남은수량
    let remaining = ${product.getProduct_count()};
    let amount;

    function init() {
        sell_price = document.form.sell_price.value;
        amount = document.form.amount.value;
        document.form.sum.value = sell_price;
        change();
    }

    function add() {
        hm = document.form.amount;
        sum = document.form.sum;
        if (hm.value < remaining) {
            hm.value++;
        }
        sum.value = parseInt(hm.value) * sell_price;
    }

    function del() {
        hm = document.form.amount;
        sum = document.form.sum;
        if (hm.value > 1) {
            hm.value--;
            sum.value = parseInt(hm.value) * sell_price;
        }
    }

    function change() {
        hm = document.form.amount;
        sum = document.form.sum;

        if (hm.value < 0) {
            hm.value = 0;
        }
        sum.value = parseInt(hm.value) * sell_price;
    }


    $(document).ready(function () {
        let pNum = ${product.getProduct_count()};
        console.log(pNum)
        if (pNum == 0) {
            $('#buyBtn').attr("disabled", true);
        }
    })
</script>

<script>
    function iamport() {
        //로그인 확인
        let id = '<%=(String)session.getAttribute("id")%>';
        if (id == "null") {
            alert("로그인이 필요한 서비스입니다.")
            location.replace("/shop/product/${product.getProduct_number()}");
        }

        //구매하는 상품의 총 가격
        let inputAmount = $('#sum').val();
        //구매하는 상품의 총 개수
        let product_amount = $('#product_amount').val();
        //구매하는 상품의 번호
        let product_number = ${product.getProduct_number()};
        console.log(product_number);
        //가맹점 식별코드
        IMP.init('imp81143209');
        IMP.request_pay({
            pg: 'kcp',
            pay_method: 'card',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: '${product.getProduct_name()}', //결제창에서 보여질 이름
            amount: inputAmount, //실제 결제되는 가격
            buyer_email: '${user.getEmail()}',
            buyer_name: '${user.getName()}',
            buyer_tel: '${user.getTelephone()}',
            buyer_addr: '${user.getAddress()}',
            buyer_postcode: '${user.getPostcode()}'
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;

                //구매 성공하면 제품 count DB에서 해당 개수만큼 빼준다.
                $.ajax({
                    url: '/shop/product/product_amount',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        "product_amount": product_amount,
                        "product_number": product_number,
                    },
                    success: function (data) {
                        location.href = "${pageContext.request.contextPath}/shop/productForm";
                    }
                })
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
        });
    };
</script>
</html>