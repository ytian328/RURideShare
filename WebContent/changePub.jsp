<%@page import = "jsp.*, java.sql.* " %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>change public status</title>
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
	Connection c = MySQL.connect();
	String sql = "update users set public=? where uid=?";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, request.getParameter("pub"));
	st.setString(2, session.getAttribute("userId").toString());
	st.execute();
	
	response.sendRedirect("myAccountPage.jsp");
	
}
catch (Exception e){
	out.print(e);
}
%>
</body>
</html>