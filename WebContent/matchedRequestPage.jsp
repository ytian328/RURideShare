<%@page import = "jsp.*, java.sql.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	out.println("welcome, " + session.getAttribute("userId")); %>
	<a href="mainUserDashboardPage.jsp">Back to main dashboard</a>
	<form action="logout.jsp" method="post">
	<input type="submit" value="Logout"  id="logout">
	</form> 
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
		<div>
			<p>Ride offer information: </p>
			<p>Departure lot: <%= offerRs.getString("dep") %>,     Destination lot: <%= offerRs.getString("des")%></p>
			<p>Date: <%= offerRs.getString("date")%>,    Departure time: <%= offerRs.getString("timef") %> - <%= offerRs.getString("timet")%></p>
			<p></p>
		</div>
		<%
		String sql = "select * from requests where status='ACT' and dep =? and des=? and date=? and timef<=? and timet>=?";
		PreparedStatement st = c.prepareStatement(sql);
		st.setInt(1, offerRs.getInt("dep"));
		st.setInt(2, offerRs.getInt("des"));
		st.setDate(3, offerRs.getDate("date"));
		st.setTime(4, offerRs.getTime("timet"));
		st.setTime(5, offerRs.getTime("timef"));
		ResultSet rs = st.executeQuery();
		%>
		
		<table align="center" cellpadding="7" cellspacing="2" border="1">
		<caption>Matched Request</caption>
			<tr align="center">
				<td>Request ID</td>
				<td>Passenger</td>
				<td>Departure time from</td>
				<td>Departure time to</td>
				<td>Passenger info</td>
				<td>Send Offer</td>				
			</tr>
	<%
	while(rs.next()) {
		%>
		<tr align="center">
			<td><%=rs.getString("rid") %></td>
			<td><%=rs.getString("pid") %></td>
			<td><%=rs.getString("timef") %></td>
			<td><%=rs.getString("timet") %></td>
			<td>
				<form action="passengerInfo.jsp" method="post">
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
	</table>
	<%
		
	}
}
catch(Exception e) {
	out.print(e);
}
%>


</body>
</html>