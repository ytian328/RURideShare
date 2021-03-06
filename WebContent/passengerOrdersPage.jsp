<%@page import = "jsp.*, java.sql.*, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/historyStyle.css">
<title>Ride Orders as A Passenger</title>
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
	
	<table align="center" cellpadding="7" cellspacing="2" border="1">
	<caption>Passenger Orders</caption>
	<thead><tr> 
		<td>Order Id</td>
		<td>From lot</td>
		<td>To lot</td>
		<td>Date</td>
		<td>Regular</td>
		<td>Departure time from</td>
		<td>Departure time to</td>
		<td>Car info.</td>
		<td>DriverId</td>
		<td>Driver email</td>
		<td>Cancel order</td>
		<td>Finish</td>
	</tr></thead>
	<tbody>
	<%
	Connection c = MySQL.connect();
	String sql = "select r.dep, r.des, r.date, r.timef, r.timet, r.regular, o.timef, o.timet, o.did, o.plate, m.status, m.mid, m.revstat, u.email2 "
				+ "from requests r, offers o, matches m, users u "
				+ "where m.status='CFM' and r.pid=? and m.rid=r.rid and m.oid=o.oid and o.did=u.uid ";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, session.getAttribute("userId").toString());
	ResultSet rs = st.executeQuery();
	while(rs.next()) {
		Date now = new Date();
		String timet = rs.getTime("r.timet").after(rs.getTime("o.timet"))? rs.getString("o.timet") : rs.getString("r.timet");
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("date") + " " + timet);
		if(date.after(now)) {
			String carSql = "select * from cars where plate=?";
			PreparedStatement carSt = c.prepareStatement(carSql);
			carSt.setString(1, rs.getString("o.plate"));
			ResultSet carRs = carSt.executeQuery();
			if(carRs.next()) {
				%>
		<tr>
			<td><%=rs.getString("m.mid") %></td>
			<td><%=rs.getString("r.dep") %></td>
			<td><%=rs.getString("r.des") %></td>
			<td><%=rs.getString("r.date") %></td>
			<td><%=rs.getString("r.regular") %></td>
			<td><%=rs.getTime("r.timef").after(rs.getTime("o.timef"))? rs.getString("r.timef") : rs.getString("o.timef")%></td>
			<td><%=timet %></td>
			<td><%=carRs.getString("year").substring(0, 4) + ", " + carRs.getString("make") + ", " 
				+ carRs.getString("model") + ", " + carRs.getString("color") + " Plate:" + carRs.getString("plate") %></td>
			<td><%=rs.getString("o.did") %></td>
			<td><%=rs.getString("u.email2") %></td>
			<td>
				<form action="cancelOrder.jsp" method="post">
					<input type="hidden" name="mid" value="<%=rs.getString("m.mid") %>"/>
					<input type="hidden" name="returnPage" value="passengerOrdersPage.jsp"/>

					<input type="submit" value="Cancel"/>
				</form>
			</td>
			<td>
				<form action="finishOrder.jsp" method="post">
					<input type="hidden" name="mid" id="mid" value="<%=rs.getString("m.mid") %>"/>
					<input type="hidden" name="returnPage" value="passengerOrdersPage.jsp"/>
					<input type="submit" value="Confirm"/>
				</form>
			</td>

		</tr>
			<%
			}
		}
		else {
			String markExp = "update matches set status='EXP' where mid=?";
			PreparedStatement markExpSt = c.prepareStatement(markExp);
			markExpSt.setString(1, rs.getString("m.mid"));
			//System.out.println(rs.getString("m.mid"));
			markExpSt.execute();	
		}
		
		
	}%>
	</tbody></table>
<% 	
}
catch(Exception e) {
	out.println(e);
}
%>

</body>
</html>