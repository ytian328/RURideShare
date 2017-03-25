<%@page import = "jsp.*, java.sql.*, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Orders as A Driver</title>
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
	<table align="center" cellpadding="7" cellspacing="2" border="1">
	<caption>Driver Orders</caption>
	<tr> 
		<td>Order Id</td>
		<td>Departure lot</td>
		<td>Destination lot</td>
		<td>Date</td>
		<td>Departure time from</td>
		<td>Departure time to</td>
		<td>Car info.</td>
		<td>PassengerId</td>
		<td>Passenger email</td>
		<td>Order Status</td>
		<td>Cancel</td>
	</tr>
	<%
	Connection c = MySQL.connect();
	String sql = "select r.timef, r.timet, u.email2, u.uid, o.*, c.*, m.mid, m.status "
			+ "from requests r, offers o, matches m, users u, cars c "
			+ "where m.status='CFM' and m.oid=o.oid and o.did=? and m.rid=r.rid and  r.pid=u.uid and c.plate = o.plate";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, session.getAttribute("userId").toString());
	ResultSet rs = st.executeQuery();
	while(rs.next()) {
			%>
	<tr>
		<td><%=rs.getString("m.mid") %></td>
		<td><%=rs.getString("o.dep") %></td>
		<td><%=rs.getString("o.des") %></td>
		<td><%=rs.getString("o.date") %></td>
		<td><%=rs.getTime("r.timef").after(rs.getTime("o.timef"))? rs.getString("r.timef") : rs.getString("o.timef")%></td>
		<td><%=rs.getTime("r.timet").after(rs.getTime("o.timet"))? rs.getString("o.timet") : rs.getString("r.timet") %></td>
		<td><%=rs.getString("c.year").substring(0,4) + ", " + rs.getString("c.make") + ", " 
			+ rs.getString("c.model") + ", " + rs.getString("c.color") + "\nPlate:" + rs.getString("c.plate") %></td>
		<td><%=rs.getString("u.uid") %></td>
		<td><%=rs.getString("u.email2") %></td>
		<td><%=rs.getString("m.status") %></td>
		<td><%
			if(rs.getString("m.status").equals("CFM")){ %>
				<form action="cancelOrder.jsp" method="post">
					<input type="hidden" name="mid" id="mid" value="<%=rs.getString("m.mid") %>"/>
					<input type="submit" value="Cancel"/>
				</form>
			<%}
			else %><p>N/A</p>
		</td>
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