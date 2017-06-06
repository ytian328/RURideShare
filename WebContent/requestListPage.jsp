<%@page import = "jsp.*, java.sql.*, java.util.Date, java.text.*, java.util.Map, java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/historyStyle.css">
<title>My Requests</title>
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
	String userId = session.getAttribute("userId").toString();
	Connection c = MySQL.connect();
	String sql = "select * from requests where pid=? and status='ACT' and regular='N' order by rtime desc";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, userId);
	ResultSet rs = st.executeQuery();
	%>
	<table align="center" cellpadding="7" cellspacing="2" border="0">
			<caption>Current Active Requests (Single Ride)</caption>
				<thead><tr align="center">
					<td>Request ID</td>
					<td>Departure</td>
					<td>Destination</td>
					<td>Date</td>
					<td>Departure time from</td>
					<td>Departure time to</td>
					<td>Number of passengers</td>
					<td>Cancel request</td>
					<td>See matched offers</td>
					
				</tr></thead>
				<tbody>

	<% 
	while(rs.next()) {
		Date now = new Date();
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("date") + " " + rs.getString("timet"));
		if(date.after(now)){
			%>
			
				<tr align="center">
					<td><%=rs.getString("rid") %></td>
					<td><%=rs.getString("dep") %></td>
					<td><%=rs.getString("des") %></td>
					<td><%=rs.getString("date") %></td>
					<td><%=rs.getString("timef") %></td>
					<td><%=rs.getString("timet") %></td>
					<td><%=rs.getString("capacity") %></td>
					<td>
						<form action="cancelRequest.jsp" method="post">
							<input type="hidden" name="cancel" id="cancel" value="<%=rs.getString("rid") %>"/>
							<input type="submit" value="Cancel"/>
						</form>
					</td>
					<td>
						<form action="matchedOfferPage.jsp" method="post">
							<input type="hidden" name="rid" id="rid" value="<%=rs.getString("rid") %>"/>
							<input type="submit" value="Offers"/>
						</form>
					</td>
				</tr>	
		<%}
		else {
			String markExp = "update requests set status='EXP' where rid=?";
			PreparedStatement markExpSt = c.prepareStatement(markExp);
			markExpSt.setString(1, rs.getString("rid"));
			markExpSt.execute();
		}
	}
	%>
	</tbody></table>
	<br>
	<br>
	<% 
	sql = "select * from requests where pid=? and status='ACT' and regular='Y' order by rtime desc";
	st = c.prepareStatement(sql);
	st.setString(1, userId);
	rs = st.executeQuery();
	%>
	<table align="center" cellpadding="7" cellspacing="2" border="0">
			<caption>Current Active Requests (Regular Ride)</caption>
				<thead><tr align="center">
					<td>Request ID</td>
					<td>Departure</td>
					<td>Destination</td>
					<td>Date from</td>
					<td>Day of Week</td>
					<td>Departure time from</td>
					<td>Departure time to</td>
					<td>Number of passengers</td>
					<td>Cancel request</td>
					<td>See matched offers</td>
					
				</tr></thead>
				<tbody>

	<% 
	Map<Integer, String> days = new HashMap<Integer, String>();
	days.put(1, "SUN");
	days.put(2, "MON");
	days.put(3, "TUE");
	days.put(4, "WED");
	days.put(5, "THU");
	days.put(6, "FRI");
	days.put(7, "SAT");
	
	while(rs.next()) {
			%>
			
		<tr align="center">
			<td><%=rs.getString("rid") %></td>
			<td><%=rs.getString("dep") %></td>
			<td><%=rs.getString("des") %></td>
			<td><%=rs.getString("date") %></td>
			<td><%=days.get(rs.getInt("day")) %></td>
			<td><%=rs.getString("timef") %></td>
			<td><%=rs.getString("timet") %></td>
			<td><%=rs.getString("capacity") %></td>
			<td>
				<form action="cancelRequest.jsp" method="post">
					<input type="hidden" name="cancel" id="cancel" value="<%=rs.getString("rid") %>"/>
					<input type="submit" value="Cancel"/>
				</form>
			</td>
			<td>
				<form action="matchedOfferPage.jsp" method="post">
					<input type="hidden" name="rid" id="rid" value="<%=rs.getString("rid") %>"/>
					<input type="submit" value="Offers"/>
				</form>
			</td>
		</tr>	
		<%
	}
	%>
	</tbody></table>
	<% 
	
	
	
	
}
catch(Exception e) {
	out.println(e);
}
%>
	
	
</body>
</html>