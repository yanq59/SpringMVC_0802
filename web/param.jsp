<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/8/2
  Time: 13:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/param/getParam5" method="post">
<%--  name 跟属性对应  --%>
    userid:<input type="text" name="userid" value="123"><br>
    username:<input type="text" name="username" value="admin"><br>
    username:<input type="password" name="password" value="123"><br>
    age:<input type="text" name="age" value="12"><br>
    birthday:<input type="date" name="birthday"><br>
    skill:<input type="checkbox" name="skill" value="1">javase
    <input type="checkbox" name="skill" value="2">html
    <input type="checkbox" name="skill" value="3">css
    <input type="checkbox" name="skill" value="4">mysql<br>
    empno:<input type="text" name="empno" value="001"><br>
    ename:<input type="text" name="ename" value="allen"><br>
    <input type="submit" value="提交">
</form>
</body>
</html>
