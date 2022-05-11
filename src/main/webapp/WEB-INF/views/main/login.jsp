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
        body{ padding-top: 100px;}

    </style>
</head>
<body>
<form action="/login" method="post" onsubmit="return formCheck(this)";>
    <div class="container">
            <div class="card">
                <div id="msg">
                    <c:if test="${not empty param.msg}">
                    <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
                    </c:if>
                </div>
                <div>
                <label>아이디</label>
                <input type="text" name="id" value="${cookie.id.value}">
                </div>

                <div>
                    <label>비밀번호</label>
                    <input type="password" name="password">
                </div>
            </div>
            <div>
                <input type="checkbox" name="remeberId" value="on" ${empty cookie.id.value ? "":"checked"}>로그인저장
            </div>
            <div>
                <button type="submit">로그인</button>
            </div>

    </div>


<script>
    function formCheck(frm) {
        let msg ='';

        if(frm.id.value.length==0) {
            setMessage('id를 입력해주세요.', frm.id);
            return false;
        }

        if(frm.pwd.value.length==0) {
            setMessage('password를 입력해주세요.', frm.pwd);
            return false;
        }
        return true;
    }

    function setMessage(msg, element){
        document.getElementById("msg").innerHTML = ` ${'${msg}'}`;

        if(element) {
            element.select();
        }
    }
</script>
    </form>
</body>
</html>