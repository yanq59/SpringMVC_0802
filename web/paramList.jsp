<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/8/2
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/param/getParam6" method="post">
    <%--  name 跟属性对应  --%>
    userid:<input type="text" name="userList[0].userid" value="123"><br>
    username:<input type="text" name="userList[0].username" value="admin"><br>
    username:<input type="password" name="userList[0].password" value="123"><br>
    age:<input type="text" name="userList[0].age" value="12"><br>
    birthday:<input type="date" name="userList[0].birthday"><br>
    skill:<input type="checkbox" name="userList[0].skill" value="1">javase
    <input type="checkbox" name="userList[0].skill" value="2">html
    <input type="checkbox" name="userList[0].skill" value="3">css
    <input type="checkbox" name="userList[0].skill" value="4">mysql<br>

    userid:<input type="text" name="userList[1].userid" value="123"><br>
    username:<input type="text" name="userList[1].username" value="admin"><br>
    username:<input type="password" name="userList[1].password" value="123"><br>
    age:<input type="text" name="userList[1].age" value="12"><br>
    birthday:<input type="date" name="userList[1].birthday"><br>
    skill:<input type="checkbox" name="userList[1].skill" value="1">javase
    <input type="checkbox" name="userList[1].skill" value="2">html
    <input type="checkbox" name="userList[1].skill" value="3">css
    <input type="checkbox" name="userList[1].skill" value="4">mysql<br>

    <input type="submit" value="提交">

</form>
</body>
</html>