
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
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

if(session.getAttribute("userId") == null) {
	out.println("login first");
	%>
	<a href="loginPage.jsp">Log in</a>
	<%
}
else try{
	out.println("welcome, " + session.getAttribute("userId")); %>
	<a href="mainUserDashboardPage.jsp">Back to main dashboard</a>
	<form action="logout.jsp" method="post">
	<input type="submit" value="Logout"  id="logout">
	</form> 
<%	
	String uid = request.getParameter("uid");
	Connection c = MySQL.connect();
	String userSql = "select uid, fname, lname, email2, public, regtime from users where uid=?";
	PreparedStatement userSt = c.prepareStatement(userSql);
	userSt.setInt(1, Integer.parseInt(uid));
	ResultSet userRs = userSt.executeQuery();
	if(userRs.next()) {
		%>
		<table>
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
				<td>show something here..</td>
			</tr>
		<%}%>
		</table>
		<a href="matchedOfferPage.jsp">Back</a><%
	}
}
catch(Exception e) {
	out.println(e);
}%>
</body>
</html>