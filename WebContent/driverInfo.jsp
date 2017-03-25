
<%@page import = "jsp.*, java.sql.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Driver Information</title>
</head>
<body>
<%
try{

	String uid = request.getParameter("uid");
	Connection c = MySQL.connect();
	String userSql = "select uid, fname, lname, email2, public, regtime from users where uid=?";
	PreparedStatement userSt = c.prepareStatement(userSql);
	userSt.setString(1, uid);
	ResultSet userRs = userSt.executeQuery();
	if(userRs.next()) {
		%>
		<table>
		<caption>Driver Info.</caption>
			<tr>
				<td>UserId</td>
				<td><%=userRs.getString("uid") %></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><%=userRs.getString("email2") %></td>
			</tr>
			
		<% 
		if(userRs.getString("public").equals("Y")) { %>
			<tr>
				<td>Name</td>
				<td><%=userRs.getString("fname") + " " + userRs.getString("lname") %></td>
			</tr>
			<tr>
				<td>User since: </td>
				<td><%=userRs.getString("regtime") %></td>
			</tr>
			<tr>
				<td>Rating</td>
				<td><%=MySQL.rating(c, uid, "D") %></td>
			</tr>
		<%}%>
		</table>
<%
	}
}
catch(Exception e) {
	out.println(e);
}%>
</body>
</html>