<%@page import = "jsp.*, java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%
	String userId = request.getParameter("usr");
	
	String pwd = request.getParameter("pwd");
	Connection c = MySQL.connect();
	Statement st = c.createStatement();
	ResultSet rs = st.executeQuery("select * from users where user_id = '"+userId+"'");
	if(rs.next()) {
		if(rs.getString(2).equals(pwd)){
			session = request.getSession();
			session.setAttribute("userId", userId);
			response.sendRedirect("mainUserDashboardPage.jsp"); 
		}
		else out.println("wrong password, try again");
	}
	else {
		out.println("user does not exist, try again");
		response.sendRedirect("index.html");
	}
	%>
	

</body>
</html>