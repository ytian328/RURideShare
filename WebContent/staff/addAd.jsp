<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>add ad</title>
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
else if(request.getParameter("name").equals("") || request.getParameter("url").equals("")){
	response.sendRedirect("adPage.jsp");
}
else try{
	Connection c = MySQL.connect();
	String sql = "insert into ads(name, url, reward) values(?,?,?)";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, request.getParameter("name"));
	st.setString(2, request.getParameter("url"));
	st.setInt(3, Integer.parseInt(request.getParameter("reward")));
	st.execute();
	response.sendRedirect("adPage.jsp");
}
catch(Exception e) {
	out.print(e);
}
%>
</body>
</html>