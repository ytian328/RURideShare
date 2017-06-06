<%@page import = "jsp.*, java.sql.*, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/historyStyle.css">
<title>Driver Trip History</title>
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
	
	<table align="center" cellpadding="7" cellspacing="2" border="1">
	<caption>Passenger Trip History</caption>
	<thead><tr> 
		<td>Order ID</td>
		<td>From lot</td>
		<td>To lot</td>
		<td>Date</td>
		<td>Departure time window</td>
		<td>Car info.</td>
		<td>PassengerID</td>
		<td>Passenger email</td>
		<td>Status</td>
		<td>Review</td>
	</tr></thead>
	
<%

	try {
	Connection c = MySQL.connect();
	String pid = session.getAttribute("userId").toString();
	
	String sql = "select r.dep, r.des, r.date, r.timef, r.timet, o.timef, o.timet, r.pid, m.status, m.mid, u.email2, c.* "
			+ "from requests r, offers o, matches m, users u, cars c "
			+ "where (m.status='CNL' or m.status='FNS' or m.status='EXP') and o.did=? and m.rid=r.rid and m.oid=o.oid and r.pid=u.uid and c.plate=o.plate ";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, session.getAttribute("userId").toString());
	ResultSet rs = st.executeQuery();
	while(rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("m.mid") %></td>
			<td><%=rs.getString("r.dep") %></td>
			<td><%=rs.getString("r.des") %></td>
			<td><%=rs.getString("r.date") %></td>
			<% 
			String timef = rs.getTime("r.timef").after(rs.getTime("o.timef"))? rs.getString("r.timef") : rs.getString("o.timef");
			String timet = rs.getTime("r.timet").after(rs.getTime("o.timet"))? rs.getString("o.timet") : rs.getString("r.timet");
			%>
			<td><%=timef.substring(0,5) + " - " + timet.substring(0,5) %></td>
			<td><%=rs.getString("c.year").substring(0, 4) + ", " + rs.getString("c.make") + ", " 
			+ rs.getString("c.model") + ", " + rs.getString("c.color") + " Plate:" + rs.getString("c.plate") %></td>
			<td><%=rs.getString("r.pid") %></td>
			<td><%=rs.getString("u.email2") %></td>
			<td><%=rs.getString("m.status") %></td>
			<%
			if(rs.getString("m.status").equals("FNS")) {
			%>
			<td>
				<form action="reviewPage.jsp" method="post">
					<input type="hidden" name="mid" id="mid" value="<%=rs.getString("m.mid") %>"/>
					<input type="hidden" name="role" id="role" value="d"/>
					<input type="submit" value="Review"/>
				</form>
			</td>
			<%	
			}
			else {
			%>
			<td>N/A</td>
			<%
			}
			%>
			
		</tr>
		<% 
		
		
		}
	%>
	</table>
	<%

	}
	catch(Exception e) {
		out.print(e);
	}
}


%>

</body>
</html>