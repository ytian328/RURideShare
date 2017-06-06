<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/mainStyle.css">
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
		%><div><% 
		out.println("Welcome, ");
	%>
		
		<a href="myAccountPage.jsp"><%= session.getAttribute("userId")%></a>
		<p>
		<a href="mainUserDashboardPage.jsp">Back to main dashboard</a>
		<form action="logout.jsp" method="post">
			<input type="submit" value="Logout"/>
		</form>
		</div>
		<p>

<table align="center">
	<thead>
	<tr align="center">
		<td>As Passenger</td>
		<td>As Driver</td>
	</tr>
	</thead>
	<tr align="center">
		<td><a href="requestRidePage.jsp">Request Ride</a></td>
		<td><a href="postRideOfferPage.jsp">Post Ride Offer</a></td>
	</tr>
	<tr align="center">
		<td><a href="requestListPage.jsp">My Active Ride Requests</a></td>
		<td><a href="rideOfferListPage.jsp">My Active Ride Offers</a></td>
	</tr>
	<tr align="center">
		<td><a href="passengerOrdersPage.jsp">Passenger Trips</a></td>
		<td><a href="driverOrdersPage.jsp">Driver Trips</a></td>
	</tr>
	<tr align="center">
		<td><a href="passengerOrderHistoryPage.jsp">Passenger Trip History</a></td>
		<td><a href="driverOrderHistoryPage.jsp">Driver Trip History</a></td>
	</tr>
	
</table>
<%
	}
%>
</body>
</html>