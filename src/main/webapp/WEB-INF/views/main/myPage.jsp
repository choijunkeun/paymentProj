<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page session="false" %>
<!doctype html>
<html lang=>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        body {
            padding-top: 100px;
        }
        p {
            font-size: 20px;
        }
        .card{
            padding : 20px;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div id="orderList">
        </div>




    </div>
</div>


</body>


<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>

    $(document).ready(function () {
        $.ajax({
            url: '/myPage/order',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                $.each(data, function (index, item) {
                    let old_date = item.reg_date;
                    let date = old_date.slice(0, 10);
                    let time = old_date.slice(11,16);
                    let week = ['일', '월', '화', '수', '목', '금', '토'];
                    let dayOfWeek = week[new Date(date).getDay()];

                    $("#orderList").append("<div class='card'><p>주문서</p>주문상품 : "+item.product_name+"<br>주문가격 : "+item.order_price+
                        "<br>주문개수 : "+item.order_amount+"<br>주문날짜 : "+date+ "("+dayOfWeek+")"+" "+time+" <br><br>" +
                        "<p>배송지정보</p>주문자 : "+item.name+"<br>연락처 : "+item.telephone+"<br>" +
                        "배송지 : "+item.address+" <br>배송메모 : "+item.request_message+"</div>");
                });
            }
        })

    });


</script>
</html>