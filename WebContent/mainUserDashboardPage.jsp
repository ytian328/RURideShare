<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Main User Dashboard</title>
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
		out.println("welcome, " + session.getAttribute("userId"));
	
	
%>
<form action="mainUserDashboard.jsp" method="post">
<a href="requestRidePage.jsp">Request Ride</a>
<br>
<a href="postRideOfferPage.jsp">Post Ride Offer</a>
<br>
<br>
<a href="orderHistoryPage.jsp">Order History</a>
<br>
<br>
<a href="myAccountPage.jsp">My Account</a>
</form>


<form action="logout.jsp" method="post">
<input type="submit" value="Logout"/>
</form>
<%
}
%>
</body>
</html>