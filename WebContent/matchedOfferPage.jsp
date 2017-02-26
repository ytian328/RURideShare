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
	</form> <%
	
	
	String rid = request.getParameter("match");	
	Connection c = MySQL.connect();
	String requestSql = "select * from requests where rid=?";
	PreparedStatement requestSt = c.prepareStatement(requestSql);
	requestSt.setInt(1, Integer.parseInt(rid));
	ResultSet requestRs = requestSt.executeQuery();
	if(requestRs.next()) {
		//needs to display this request
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
	
	<%
	
	String sql = "select oid, mid from matches where rid=?";
	PreparedStatement st = c.prepareStatement(sql);
	st.setInt(1, Integer.parseInt(rid));
	ResultSet rs = st.executeQuery();
	
	while(rs.next()) {
		String offerSql = "select * from offers where oid=?";
		PreparedStatement offerSt = c.prepareStatement(offerSql);
		offerSt.setInt(1, Integer.parseInt(rid));
		ResultSet offerRs = offerSt.executeQuery();
		if(offerRs.next()) {
			String carSql = "select * from cars where plate=?";
			PreparedStatement carSt = c.prepareStatement(carSql);
			carSt.setString(1, rs.getString("plate"));
			ResultSet carRs = carSt.executeQuery();
			if(carRs.next()) {
				%>
				<tr>
					<td><%=rs.getString("mid") %></td>
					<td><%=offerRs.getString("did") %></td>
					<td><%=carRs.getString("year") + ", " + carRs.getString("brand") + ", " + carRs.getString("model") + ", " + carRs.getString("color") %></td>
					<td><%=offerRs.getString("timef") %></td>
					<td><%=offerRs.getString("timet") %></td>
					<td><form action="driverInfo.jsp" method="post">
							<input type="hidden" name="uid" id="uid" value="<%=offerRs.getString("did") %>"/>
							<input type="submit" value="View"/>
						</form></td>
					<td><form action="acceptOffer.jsp" method="post">
							<input type="hidden" name="accept" id="accept" value="<%=rs.getString("mid") %>"/>
							<input type="submit" value="Accept"/>
						</form></td>
				</tr>
				<%
			}
			
		}
	}
	%></table><%
	
}
catch(Exception e) {
	out.println(e);
}
%>

</body>
</html>