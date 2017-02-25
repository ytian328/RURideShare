<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Login</title>
</head>
<body>
<form action="login.jsp" method="post">
<table>
	<tr>
		<td><label for="usr">User Name</label></td>
		<td><input type="text" name="usr"/></td>
		<td><a href="forgotUserId.html">Forgot user ID?</a></td>
	</tr>
	<tr>
		<td><label for="pwd">Password</label></td>
		<td><input type="password" name="pwd"/></td>
		<td><a href="forgotPwd.html">Forgot password?</a></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" id="log_in" value="log in" /></td>
		<td><a href="registerPage.jsp">Register</a></td>
	</tr>
</table>
</form>

<br>


</body>
</html>