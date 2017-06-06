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
	int aid = Integer.parseInt(request.getParameter("aid"));
	Connection c = MySQL.connect();
	String sql = "delete from ads where aid=?";
	PreparedStatement st = c.prepareStatement(sql);
	st.setInt(1, aid);
	st.execute();
	response.sendRedirect("adPage.jsp");
}
catch(Exception e) {
	out.print(e);
}
%>
</body>
</html>