<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/postStyle.css">
<title>Retrieve Password</title>
</head>
<body>

<form action="forgotPwd.jsp" method="post">
<table>
<tr>
	<td><label for="email">Email</label></td>
	<td><input type="text" name="email"/></td>
	<td><input type="submit" value="submit"></td>
</tr>
</table>
</form>
<a href="loginPage.jsp">Back to login page</a>
</body>
</html>