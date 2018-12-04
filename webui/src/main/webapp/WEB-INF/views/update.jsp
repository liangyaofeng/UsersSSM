<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>修改</title>
</head>
<body>
<form action="updateUsers">
    <input type="hidden" name="id" value="${users.id}"><br>
    账号：<input type="text" name="username" value="${users.username}"><br>
    电话：<input type="text" name="phone" value="${users.phone}"><br>
    邮箱：<input type="text" name="email" value="${users.email}"><br>
    日期：<input type="datetime-local" name="Udate" value="${users.udate}"><br>
    <input type="submit" value="提交">&nbsp;&nbsp;
    <input type="reset" value="重置">
</form>
</body>
</html>
