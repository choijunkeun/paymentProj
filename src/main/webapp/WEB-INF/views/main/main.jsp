<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang=>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        body{ padding-top: 100px;}

        .carousel {
            max-width: 100%;
            max-height : 400px;
        }

        #buy {
            max-width: 150px;
        }



    </style>

</head>
<body id="body">
<div class="container">
    <div id="carousel" class="carousel carousel-dark slide" data-bs-ride="carousel" data-bs-interval="3000">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${path}resources/img/carousel1.jpeg" class="banner" type="image / svg + xml" codebase="http://www.adobe.com / svg / viewer / install " />
            </div>
            <div class="carousel-item">
                <img src="${path}resources/img/carousel2.jpeg" class="banner" type="image / svg + xml" codebase="http://www.adobe.com / svg / viewer / install " />
            </div>

        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <div class="card">
        <img src="resources/img/item.jpeg" id="buy"/>
        <a href="/shop">쇼핑하러가기</a>
    </div>


</div>


</body>
</html>