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

        #selboxDirect {
            width: 373px;
        }

        .card {
            margin-bottom: 20px;
        }

    </style>
</head>
<body>
<form action="POST" id="form">
<%--<form action="/test" method="post">--%>
    <div class="container">
        <div class="card">
            <div>
                <p>배송지</p>
                <input type="hidden" name="id" value="${user.getId()}">
                ${user.getName()}<br>
                ${user.getTelephone()}<br>
                ${user.getAddress()}<br>
                <select id="req_msg" name="req_msg">
                    <optgroup label="배송시 요청사항을 선택해주세요" default>
                        <option value="부재 시 경비실에 맡겨주세요">부재 시 경비실에 맡겨주세요</option>
                        <option value="부재 시 택배함에 넣어주세요">부재 시 택배함에 넣어주세요</option>
                        <option value="부재 시 집앞에 놔주세요">부재 시 집앞에 놔주세요</option>
                        <option value="배송 전 연락바랍니다">배송 전 연락바랍니다</option>
                        <option value="파손의 위험이 있는 상품입니다. 배송 시 주의해 주세요">파손의 위험이 있는 상품입니다. 배송 시 주의해 주세요</option>
                        <option value="direct">직접 입력</option>
                    </optgroup>
                </select><br>
                <input type="text" id="req_msg_direct" name="req_msg_direct"/>
            </div>
        </div>

        <div class="card">
            <p>상품 정보</p>
            ${product.getProduct_name()}<br>
            수량 ${amount} 개<br>
            ${sum} 원
            <input type="hidden" name="product_number" value="${product.getProduct_number()}" />
            <input type="hidden" name="order_amount" value="${amount}" />
            <input type="hidden" name="order_price" value="${sum}" />
        </div>
        <button class="btn btn-lg btn-primary btn-block" id="submit" type="button">구매하기</button>
<%--        <button type="submit">테스트버튼</button>--%>
    </div>
</form>


</body>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script>
    $(function () {
        //직접입력 인풋박스 기존에는 숨어있다가
        $("#req_msg_direct").hide();
        $("#req_msg").change(function () {
            //직접입력을 누를 때 나타남
            if ($("#req_msg").val() == "direct") {
                $("#req_msg_direct").show();
            } else {
                $("#req_msg_direct").hide();
            }
        })
    });
</script>
<script>
    $(function () {
        $('#submit').on("click", function () {
            var data = $("#form").serialize();
            console.log(data);
            $.ajax({
                type: "POST",
                url: "/shop/product/order/buy",
                data: data,
                dataType: 'json',
                success: function (data) {
                    // alert("결제 시도");
                    //결제
                    function iamport() {
                        <%--
                        //로그인 확인
                        let id = '<%=(String)session.getAttribute("id")%>';
                        if (id == "null") {
                            alert("로그인이 필요한 서비스입니다.")
                            location.replace("/shop/product/${product.getProduct_number()}");
                        }
                        --%>

                        //구매하는 상품의 총 가격(결제 될 가격)
                        let inputAmount = data.order.order_price;
                        //구매하는 상품의 이름
                        let product_name = data.product.product_name;
                        //구매자 정보
                        let email = data.user.email;
                        let name = data.user.name;
                        let tel = data.user.telephone;
                        let addr = data.user.address;
                        let postcode = data.user.postcode;

                        //가맹점 식별코드
                        IMP.init('imp81143209');
                        IMP.request_pay({
                            pg: 'kcp',
                            pay_method: 'card',
                            merchant_uid: 'merchant_' + new Date().getTime(),
                            name: product_name, //결제창에서 보여질 이름
                            amount: inputAmount, //실제 결제되는 가격
                            buyer_email: email,
                            buyer_name: name,
                            buyer_tel: tel,
                            buyer_addr: addr,
                            buyer_postcode: postcode
                        }, function (rsp) {
                            console.log(rsp);
                            if (rsp.success) {
                                var msg = '결제가 완료되었습니다.';
                                msg += '고유ID : ' + rsp.imp_uid;
                                msg += '상점 거래ID : ' + rsp.merchant_uid;
                                msg += '결제 금액 : ' + rsp.paid_amount;
                                msg += '카드 승인번호 : ' + rsp.apply_num;

                                location.href = "${pageContext.request.contextPath}/";

                                //구매 성공하면 주문서 DB에 저장
                                let id = data.order.id;
                                let order_amount = data.order.order_amount;
                                let order_price = data.order.order_price;
                                let product_number = data.order.product_number;
                                let request_message = data.order.request_message;
                                $.ajax({
                                    url: '/shop/product/order/buySuccess',
                                    type: 'POST',
                                    data: {
                                        "id" : id,
                                        "order_amount" : order_amount,
                                        "order_price" : order_price,
                                        "product_number" : product_number,
                                        "request_message" : request_message
                                    },
                                    dataType: 'json',
                                    async: false,
                                    success: function (data) {
                                        console.log(data);
                                        console.log("2번째 ajax 성공")
                                    }
                                })


                            } else {
                                var msg = '결제에 실패하였습니다.';
                                msg += '에러내용 : ' + rsp.error_msg;
                                location.reload();
                            }
                            alert(msg);
                        });
                    };
                    //결제
                    iamport();




                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);

                }
            });
        });
    });

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