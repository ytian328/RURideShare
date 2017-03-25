<%@page import = "jsp.*, java.sql.* " %>
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
else {
	String mid = request.getParameter("mid");
	String rating = request.getParameter("rating");
	String comm = request.getParameter("comment");
	String role = request.getParameter("role");
	System.out.println(mid);
	System.out.println(rating);
	System.out.println(comm);
	System.out.println(role);
	System.out.println(session.getAttribute("userId").toString());
	

	Connection c = MySQL.connect();
	String sql = "insert into reviews (mid, role, uid, rating, comm) values (?,?,?,?,?)";
	PreparedStatement st = c.prepareStatement(sql);
	st.setInt(1, Integer.parseInt(mid));
	st.setString(2, role);
	st.setString(3, session.getAttribute("userId").toString());
	st.setInt(4, Integer.parseInt(rating));
	st.setString(5, comm);
	st.execute();
	
	
	if(role.equals("p")){
		response.sendRedirect("passengerOrderHistoryPage.jsp");
	}
	else {
		response.sendRedirect("driverOrderHistoryPage.jsp");
	}
	 
	
}
%>

</body>
</html>