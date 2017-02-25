<%@page import = "jsp.*, java.sql.*, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post Ride Offer</title>
</head>
<body>

</body>
</html>
<% 
String userId = session.getAttribute("userId").toString();

String dep = request.getParameter("lotd");
String des = request.getParameter("lota");

String date = request.getParameter("date");
String timef = request.getParameter("timef");
String timet = request.getParameter("timet");
String capacity = request.getParameter("passenger");
if(dep.equals("") || des.equals("") || date.equals("") || timef.equals("") || timet.equals("") || capacity.equals("")) {
	out.println("All fields must be filled!");
	%><a href="requestRidePages.jsp">Back</a><%
	return;
}

Date now = new Date();
Date d1 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + timef);
Date d2 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + timet);
if(d1.before(now) || d2.before(d1)) {
	out.println("Selected date/time is invalid!");
	%><a href="requestRidePages.jsp">Back</a><%
	return;
}

try {
	Connection c = MySQL.connect();
	String sql = "insert into requests (pid, dep, des, date, timef, timet, capacity) values (?,?,?,?,?,?,?)";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, userId);
	st.setString(2, dep);
	st.setString(3, des);
	st.setString(4, date);
	st.setString(5, timef);
	st.setString(6, timet);
	st.setString(7, capacity);
	st.execute();
	response.sendRedirect("requestListPage.jsp");
} 
catch (Exception e) {
	out.print(e);
	%><a href="requestRidePages.jsp">Back</a><%
}

%>
