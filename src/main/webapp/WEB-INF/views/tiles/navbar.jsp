<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>OJShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css"/>

    <style>

        div {
            background-color: white;
        }

        .navbar > div *,
        .navbar > div *:link,
        .navbar > div *:visited,
        .navbar > div *:hover,
        .navbar > div *:active {
            color: #111;
            text-decoration: none;
        }


    </style>
</head>

<body>
<!-- Header -->
<div>
    <div class="container-fluid navbar navbar-expand-md fixed-top" id="navbar">
        <a class="navbar-brand" href="/">
            <img id="logo" style="width: 120px; height: 100%; margin-left: 15px; text-decoration-line: none"
                 alt="" src="/resources/img/ojshop_logo.jpeg"/>
        </a>
        <button class="navbar-toggler border-dark p-2" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbars" aria-controls="navbars"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="fa fa-bars" style="color: black"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbars">
            <ul class="navbar-nav ml-auto pl-lg-5 pl-0">
                <c:choose>
                    <c:when test="${not empty id}">
                        <li class="nav-item">
                            <a class="nav-link" href="/myPage">주문내역</a>
                        </li>
                        <%--                                <li class="nav-item">--%>
                        <%--                                    <a class="nav-link" href="#">내 정보수정</a>--%>
                        <%--                                </li>--%>
                        <li class="nav-item">
                            <a class="nav-link" href="/logout">로그아웃</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/loginForm">로그인</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/joinForm">회원가입</a>
                        </li>

                    </c:otherwise>
                </c:choose>

            </ul>
        </div>
    </div>

</div>
</body>
</html>
