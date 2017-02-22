<%@page import = "jsp.*, java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>
	<%
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String email2 = request.getParameter("email2");
	if(email2.length() == 0) email2 = email;
	String userId = request.getParameter("userId");
	String pwd = request.getParameter("pwd");
	String pwd2 = request.getParameter("pwd2");
	if(!pwd.equals(pwd2)) {
		out.print("password does not match");
	}
	String pub = request.getParameter("pub");

	Connection c = MySQL.connect();
	
	String sql = "insert into users (user_id, password, email, last_login) values (?,?,?,?)";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, userId);
	st.setString(2, pwd);
	st.setString(3, email);
	st.setTimestamp(4, null);
	try{
		int i = st.executeUpdate();
	} catch(SQLException e) {
		out.println("SQLException: " + e.getMessage());
	} 

	%>
	<a href="index.html">Home</a>
</body>
</html>