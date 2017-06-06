<!-- currently only handling single ride scenario -->


<%@page import = "jsp.*, java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.util.Calendar" %>
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
}
else {
	String date = request.getParameter("date");
	String timef = request.getParameter("timef");
	String timet = request.getParameter("timet");
	String regular = request.getParameter("regular");
	String dep = request.getParameter("lotd");
	String des = request.getParameter("lota");
	String capacity = request.getParameter("passenger");
	if(dep == null || des == null || date == null || timef == null || timet == null || capacity == null || 
			dep.equals("") || des.equals("") || date.equals("") || timef.equals("") || timet.equals("") || capacity.equals("")) {
		out.println("All fields must be filled!");
		%><a href="postRideOfferPage.jsp">Back</a><%
		return;
	}
	
	Date now = new Date();
	Date d1 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + timef);
	Date d2 = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date + " " + timet);
	
	if(d1.before(now) || d2.before(d1)) {
		out.println("Selected date/time is invalid!");
		%>
		<a href="postRideOfferPage.jsp">Back</a>
		<%
		return;
	}
	try {
		Connection c = MySQL.connect();

		String sql = "insert into offers (did, dep, des, date, timef, timet, plate, capacity, regular, day) values (?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement st = c.prepareStatement(sql);
		st.setString(1, userId);
		st.setString(2, request.getParameter("lotd"));
		st.setString(3, request.getParameter("lota"));
		st.setString(4, date);
		st.setString(5, timef);
		st.setString(6, timet);
		st.setString(7, request.getParameter("car"));
		st.setString(8, request.getParameter("passenger"));
		st.setString(9, regular);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(d1);
		int day = calendar.get(Calendar.DAY_OF_WEEK);
		st.setInt(10, day);
		st.execute();
	
		response.sendRedirect("rideOfferListPage.jsp");	
	}
	catch(Exception e) {
		out.print(e);
		//response.sendRedirect("postRideOfferPage.jsp");
	}
}%>
