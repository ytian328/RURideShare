<%@page import = "jsp.*, java.sql.*" %>
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

String campusd = request.getParameter("campusd");
String lotd = request.getParameter("lotd");
String campusa = request.getParameter("campusa");
String lota = request.getParameter("lota");

String date = request.getParameter("date");
String timef = request.getParameter("timef");
String timet = request.getParameter("timet");
String plate = request.getParameter("car");
String capacity = request.getParameter("passenger");

Connection c = MySQL.connect();
String sql = "insert into offers (driver_id, date, time_from, time_to, departure, destination) values (?,?,?,?,?,?)";
PreparedStatement st = c.prepareStatement(sql);
st.setString(1, userId);
st.setString(2, date);
st.setString(3, timef);
st.setString(4, timet);
st.setString(5, lotd);
st.setString(6, lota);

try {
	st.execute();
	response.sendRedirect("mainUserDashboardPage.jsp");
} 
catch (Exception e) {
	out.print(e);
	response.sendRedirect("postRideOfferPage.jsp");
}







%>
