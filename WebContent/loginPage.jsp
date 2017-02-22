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
User ID: <input type="text" name="usr" />
<a href="forgotUserId.html">Forgot user ID?</a>
<br>
password: <input type="text" name="pwd" />
<a href="forgotPwd.html">Forgot password?</a>
<input type="submit" id="log_in" value="log in">
</form>

<br>
<a href="register.html">Register</a>

</body>
</html>