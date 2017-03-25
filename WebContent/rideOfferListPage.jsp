<%@page import = "jsp.*, java.sql.*, java.util.Date, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Ride Offers</title>
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
	
	String userId = session.getAttribute("userId").toString();
	Connection c = MySQL.connect();
	String sql = "select * from offers where did=? and status='ACT' order by otime desc";
	PreparedStatement st = c.prepareStatement(sql);
	st.setString(1, userId);
	ResultSet rs = st.executeQuery();
	%>
	<table align="center" cellpadding="7" cellspacing="2" border="0">
			<caption>Current Offers (Single Ride)</caption>
				<tr align="center">
					<td>Offer ID</td>
					<td>Departure</td>
					<td>Destination</td>
					<td>Date</td>
					<td>Departure time from</td>
					<td>Departure time to</td>
					<td>Cancel offer</td>
					<td>Match requests</td>				
				</tr> <% 
				
	while(rs.next()) {
		Date now = new Date();
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("date") + " " + rs.getString("timet"));
		if(date.after(now)){ %>	
				<tr align="center">
					<td><%=rs.getString("oid") %></td>
					<td><%=rs.getString("dep") %></td>
					<td><%=rs.getString("des") %></td>
					<td><%=rs.getString("date") %></td>
					<td><%=rs.getString("timef") %></td>
					<td><%=rs.getString("timet") %></td>
					<td>
						<form action="cancelOffer.jsp" method="post">
							<input type="hidden" name="cancel" id="cancel" value="<%=rs.getString("oid") %>"/>
							<input type="submit" value="Cancel"/>
						</form>
					</td>
					<td>
						<form action="matchedRequestPage.jsp" method="post">
							<input type="hidden" name="match" id="match" value="<%=rs.getString("oid") %>"/>
							<input type="submit" value="Match"/>
						</form>
					</td>
				</tr>
		<%}
		else {
			String markExp = "update offers set status='EXP' where oid=?";
			PreparedStatement markExpSt = c.prepareStatement(markExp);
			markExpSt.setString(1, rs.getString("oid"));
			markExpSt.execute();
		}
	}
}
catch(Exception e) {
	out.println(e);
}
%>
	</table>
</body>
</html>