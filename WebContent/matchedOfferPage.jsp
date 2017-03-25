<%@ page import="java.sql.*, jsp.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Matched Offers</title>
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
	String rid = request.getParameter("rid");
	Connection c = MySQL.connect();
	//display request info
	String requestSql = "select * from requests where rid=?";
	PreparedStatement requestSt = c.prepareStatement(requestSql);
	requestSt.setInt(1, Integer.parseInt(rid));
	ResultSet requestRs = requestSt.executeQuery();
	if(! requestRs.next()) {
		out.println("Request is not found");
		%><a href="requestListPage.jsp">Back</a><% 
	}
	else {
		%>
		<div>
			<p>Ride request information: </p>
			<p>Departure lot: <%= requestRs.getString("dep") %>,     Destination lot: <%= requestRs.getString("des")%></p>
			<p>Date: <%= requestRs.getString("date")%>,    Departure time: <%= requestRs.getString("timef").substring(0, 5) %> - <%= requestRs.getString("timet").substring(0, 5)%></p>
			<p></p>
		</div>
		<%
	}
	
	%>
	
	<table align="center" cellpadding="7" cellspacing="2" border="1">
	<caption>Offers</caption>
		<tr>
			<td>Match Id</td>
			<td>Driver Id</td>
			<td>Car Info</td>
			<td>Departure Time From</td>
			<td>Departure Time To</td>
			<td>View Driver Info.</td>
			<td>Accept Offer</td>
		</tr>
	
	<% //get offers from match table	
	String offerSql = "select m.mid, o.*, c.* from matches m, offers o, cars c where m.rid=? and m.status='ACT' and m.oid = o.oid and o.plate=c.plate";
	PreparedStatement offerSt = c.prepareStatement(offerSql);
	offerSt.setInt(1, Integer.parseInt(rid));
	ResultSet offerRs = offerSt.executeQuery();
	while(offerRs.next()) {
		%>
		<tr>
			<td><%=offerRs.getString("m.mid") %></td>
			<td><%=offerRs.getString("o.did") %></td>
			<td><%=offerRs.getString("c.year").substring(0, 4) + ", " + offerRs.getString("c.make") + "\n" + offerRs.getString("c.model") + ", " + offerRs.getString("c.color") %></td>
			<td><%=offerRs.getString("o.timef").substring(0, 5) %></td>
			<td><%=offerRs.getString("o.timet").substring(0, 5) %></td>
			<td><form action="driverInfo.jsp" method="post">
					<input type="hidden" name="uid" id="uid" value="<%=offerRs.getString("o.did") %>"/>
					<input type="submit" value="View"/>
				</form></td>
			<td><form action="acceptOffer.jsp" method="post">
					<input type="hidden" name="accept" id="accept" value="<%=offerRs.getString("m.mid") %>"/>
					<input type="submit" value="Accept"/>
			</form></td>
		</tr>
		<% 
	}%>
	</table>
<%
	
}
catch(Exception e) {
	out.println(e);
}
%>

</body>
</html>