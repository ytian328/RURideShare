<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
	String rid = request.getParameter("rid");
	String oid = request.getParameter("oid");
	
	Connection c = MySQL.connect();
	String mSql = "insert into matches (oid, rid) value (?, ?)";
	PreparedStatement st = c.prepareStatement(mSql);
	st.setInt(1, Integer.parseInt(oid));
	st.setInt(2, Integer.parseInt(rid));
	st.execute();
	
	String markSnd = "update offers set status='SND' where oid=?";
	PreparedStatement markSndSt = c.prepareStatement(markSnd);
	markSndSt.setInt(1, Integer.parseInt(oid));
	markSndSt.execute();
	
	response.sendRedirect("mainUserDashboardPage.jsp");
}
catch(Exception e) {
	
}
%>
</body>
</html>