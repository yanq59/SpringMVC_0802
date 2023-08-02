<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/8/2
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
msg: ${requestScope.msg}<br><br>
session: ${sessionScope.realName}<br><br>
application: ${applicationScope.times}<br><br>

userList: ${requestScope.listUser}<br><br>
${sessionScope.user}
user: ${requestScope.u}<br><br>
</body>
</html>
