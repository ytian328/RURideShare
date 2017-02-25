<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Selected Offer</title>
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
	String oid = request.getParameter("cancel");
	Connection c = MySQL.connect();
	String markCnl = "update offers set status='CNL' where oid=?";
	PreparedStatement markCnlSt = c.prepareStatement(markCnl);
	markCnlSt.setString(1, oid);
	markCnlSt.execute();
	response.sendRedirect("rideOfferListPage.jsp");
} 
catch(Exception e) {
	out.println(e);
	%><a href="rideOfferListPage.jsp">Back</a><%
}%>
</body>
</html>