<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SHOP</title>
    <style>
        body {
            padding-top: 100px;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="card">
        <div id="productList"></div>
    </div>
</div>
</body>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>

    $(document).ready(function () {
        $.ajax({
            url: '/shop/product',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log(data[0].product_name);
                $.each(data, function (index, item) {

                    $("#productList").append("<a href='/shop/product/" + item.product_number + "'>제품명 : " + item.product_name + ", 제품가격 : " + item.product_price + "</a><br>");
                });
            }
        })

    });


</script>
</html>