<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
            align: center;

        }
    </style>
</head>
<body>
<div class="container">
    <%--@elvariable id="user" type=""--%>
    <form:form modelAttribute="user" action="/join" method="post">
        <div class="card">
            <div class="title">
                    <p>회원 정보 입력</p>
            </div>
            <label>아이디</label>
            <input type="text" name="id" placeholder="1자리 이상의 문자나 숫자">
            <span class="msg"><form:errors path="id"/></span>
            <c:if test="${not empty error}">
                <span>${error}</span>
            </c:if>
            <label>비밀번호</label>
            <input type="password" name="password" placeholder="8~12자리의 영대소문자와 숫자">
            <span class="msg"><form:errors path="password"/></span>
            <label>이메일</label>
            <input type="email" name="email" placeholder="example@project.co.kr">
            <span class="msg"><form:errors path="email"/></span>
            <label>이름</label>
            <input type="text" name="name" placeholder="김첨지">
            <span class="msg"><form:errors path="name"/></span>
            <label>주소</label>
            <input type="text" name="address" placeholder="경기도 시흥시 대은로">
            <span class="msg"><form:errors path="address"/></span>
            <label>지번</label>
            <input type="text" name="postcode" placeholder="14168">
            <span class="msg"><form:errors path="postcode"/></span>
            <label>휴대번호</label>
            <input type="text" name="telephone" placeholder="01012345678">
            <span class="msg"><form:errors path="telephone"/></span>


            <input type="submit" value="회원가입">

        </div>
    </form:form>
</div>


</body>
</html>