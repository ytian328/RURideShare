<!-- currently only handling single ride scenario -->


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

response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

String userId = session.getAttribute("userId").toString();


if(userId == null) {
	out.println("login first");
	%>
	<a href="loginPage.jsp">Log in</a>
	<%
}
else {
	String date = request.getParameter("date");
	String timef = request.getParameter("timef");
	String timet = request.getParameter("timet");
	String regular = request.getParameter("regular");
	
	Date now = new Date();
	Date d1 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + timef);
	Date d2 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + timet);
	if(d1.before(now) || d2.before(d1)) {
		out.println("Selected date/time is invalid!");
		%><a href="postRideOfferPage.jsp">Back</a><%
		return;
	}
	try {
		Connection c = MySQL.connect();
		if(regular.equals("N")) {
			String sql = "insert into offers (did, dep, des, date, timef, timet, plate, capacity) values (?,?,?,?,?,?,?,?)";
			PreparedStatement st = c.prepareStatement(sql);
			st.setString(1, userId);
			st.setString(2, request.getParameter("lotd"));
			st.setString(3, request.getParameter("lota"));
			st.setString(4, date);
			st.setString(5, timef);
			st.setString(6, timet);
			st.setString(7, request.getParameter("car"));
			st.setString(8, request.getParameter("passenger"));
			st.execute();
		}
		else {
			//need to do some else....
		}
		response.sendRedirect("rideOfferListPage.jsp");	
	}
	catch(Exception e) {
		out.print(e);
		response.sendRedirect("postRideOfferPage.jsp");
	}
}%>
