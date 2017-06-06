<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Staff Home Page</title>
</head>
<body>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session.getAttribute("userId") == null) {
	out.println("login first");
%>
<a href="staffLoginPage.jsp">Log in</a>
<%
}
else {
	out.println("welcome, " + session.getAttribute("userId"));
%>
	<form action="logout.jsp" method="post">
		<input type="submit" value="Logout"/>
	</form>

<p><a href="blockUserPage.jsp">Block User Management</a></p>
<p><a href="adPage.jsp">Advertisement Management</a></p>

<%
} %>


</body>
</html>