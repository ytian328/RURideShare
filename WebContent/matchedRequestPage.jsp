<%@page import = "jsp.*, java.sql.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/historyStyle.css">
<title>Matched Requests</title>
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
<%	
	Connection c = MySQL.connect();
	String offerSql = "select * from offers where oid=?";
	PreparedStatement offerSt = c.prepareStatement(offerSql);
	offerSt.setString(1, request.getParameter("match"));
	ResultSet offerRs = offerSt.executeQuery();
	if(!offerRs.next()) {
		out.println("offer is not found");
		%><a href="rideOfferListPage.jsp">Back</a><% 
	}
	else {
		%>

			<h1>Ride offer information: </h1>
			<p>Departure lot: <%= offerRs.getString("dep") %>,     Destination lot: <%= offerRs.getString("des")%></p>
			<p>Date: <%= offerRs.getString("date")%>,   Departure time: <%= offerRs.getString("timef") %> - <%= offerRs.getString("timet")%></p>
			<p>Regular: <%=offerRs.getString("regular") %></p>
			<p></p>

		<%
		String sql = "select * from requests where status='ACT' and dep =? and des=? and date=? and timef<=? and timet>=? and regular=? and pid!=?";
		PreparedStatement st = c.prepareStatement(sql);
		st.setString(1, offerRs.getString("dep"));
		st.setString(2, offerRs.getString("des"));
		st.setDate(3, offerRs.getDate("date"));
		st.setTime(4, offerRs.getTime("timet"));
		st.setTime(5, offerRs.getTime("timef"));
		st.setString(6, offerRs.getString("regular"));
		st.setString(7, offerRs.getString("did"));
		ResultSet rs = st.executeQuery();
		%>
		
		<table align="center" cellpadding="7" cellspacing="2" border="1">
		<caption>Matched Request</caption>
			<thead><tr align="center">
				<td>Request ID</td>
				<td>Passenger</td>
				<td>Departure time from</td>
				<td>Departure time to</td>
				<td>Passenger info</td>
				<td>Send Offer</td>				
			</tr></thead>
			<tbody>
	<%
	while(rs.next()) {
		%>
		<tr align="center">
			<td><%=rs.getString("rid") %></td>
			<td><%=rs.getString("pid") %></td>
			<td><%=rs.getString("timef") %></td>
			<td><%=rs.getString("timet") %></td>
			<td>
				<form action="passengerInfo.jsp" method="post" target="_blank">
					<input type="hidden" name="uid" id="uid" value="<%=rs.getString("pid") %>"/>
					<input type="submit" value="View detail"/>
				</form>
			</td>
			<td>
				<form action="sendOffer.jsp" method="post">
					<input type="hidden" name="rid" id="rid" value="<%=rs.getString("rid") %>"/>
					<input type="hidden" name="oid" id="oid" value="<%=request.getParameter("match") %>"/>
					<input type="submit" value="Send"/>
				</form>
			</td>
		</tr>
		<% 
	}
	%>
	</tbody></table>
	<%
		
	}
}
catch(Exception e) {
	out.print(e);
}
%>


</body>
</html>