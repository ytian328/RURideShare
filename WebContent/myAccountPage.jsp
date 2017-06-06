<%@page import = "jsp.*, java.sql.*, java.util.* " %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/postStyle.css">
<title>My Account</title>
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
else{
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
}
try {
	String uid = session.getAttribute("userId").toString();
	Connection c = MySQL.connect();
	String userSql = "select * from users where uid=?";
	PreparedStatement userSt = c.prepareStatement(userSql);
	userSt.setString(1, uid);
	ResultSet userRs = userSt.executeQuery();
	%>	<table align="center" cellpadding="4" cellspacing="2" border="0">
		<caption>Personal Info.</caption>	
	<% 
	if(userRs.next()) {
		%>
			<tr>
				<td>Name:</td>
				<td><%=userRs.getString("fname") + " " + userRs.getString("lname") %></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><%=userRs.getString("email") %></td>
			</tr>
			<tr>
				<td>Secondary Email:</td>
				<td><%=userRs.getString("email2") %></td>
			</tr>
			<tr>
				<td>Register time: </td>
				<td><%=userRs.getString("regtime") %></td>
			</tr>
<%-- 			<tr>
				<td>Last login time:</td>
				<td><%=userRs.getString("login") %></td>
			</tr> --%>
			<tr>
				<td>Public:</td>
				<td>
					<table>
					<tr><td><%=userRs.getString("public") %> </td>
					<%
					String pub = "N";
					if(userRs.getString("public").equals("N")) pub = "Y";
					%>
					<td><form action="changePub.jsp" method="post">
					<input type="hidden" name="pub" value=<%=pub %>>
					<input type="submit" value=<%=pub.equals("Y")? "Hide":"Publish" %>>
					</form>
				</td></tr>
				
					</table>
				</td>
				
			</tr>
		
		<%
		
	}else {
		%>
			<tr><td>User info is not found!</td></tr>
		<% 
	}
	%>
		</table>
	<% 
	
	String carSql = "select * from cars where uid=? and status='ACT'";
	PreparedStatement carSt = c.prepareStatement(carSql);
	carSt.setString(1, uid);
	ResultSet carRs = carSt.executeQuery();
	Boolean noCar = true;
	int count = 1;
	%>
	<br>
		<table align="center" cellpadding="4" cellspacing="2" border="0">
		<caption>Car Info.</caption>
	<%
	while(carRs.next()) {
		noCar = false;
			%>
			<tr>
				<td>Car <%=count++ %></td>
				<td><%=carRs.getString("year").substring(0,4) + " " + carRs.getString("make") + " " + carRs.getString("model") + ", " + carRs.getString("color")%></td>
			</tr>
			<tr>
				<td></td>
				<td><%="Plate No.: " + carRs.getString("plate") + ", Capacity: " + carRs.getString("capacity") %></td>
			</tr>
			<tr>
				<td></td>
				<td><form action="deleteCar.jsp" method="post">
					<input type="hidden" name="plate" id="plate" value="<%=carRs.getString("plate") %>"/>
					<input type="submit" value="Delete this car"/>
				</form></td>
			</tr>
			<%
	}
	if(noCar) {
		%>
			<tr><td>You haven't added a car yet!</td></tr>
		<%
	}
	%>	
		</table>
		
		<form action="addCar.jsp" method="post">
		<table align="center" cellpadding="4" cellspacing="2" border="0">
			<tr>
				<td>Make:</td>
				<td><input type="text" name="make"></td>
				<td>Model:</td>
				<td><input type="text" name="model"></td>
				<td>Year:</td>
				<td><select name="year">
				<% Calendar calendar = new GregorianCalendar();
				int year = calendar.get(Calendar.YEAR); 
				int i = 0;
				while(i < 20) {%>
				<option><%=year - i++ %></option><%	
				}%>
		</select></td>
			</tr>
			<tr>
				<td>Color:</td>
				<td><input type="text" name="color"></td>
				<td>Plate:</td>
				<td><input type="text" name="plate"></td>
				<td>Capacity:</td>
				<td><select name="capacity">
					<option><%= 1%></option>
					<option><%= 2%></option>
					<option><%= 3%></option>
					<option><%= 4%></option>
					</select></td>
			</tr>
			<tr><td><input type="submit" value="Add"></td></tr>
		</table>
		</form>

	<table align="center" cellpadding="4" cellspacing="2" border="0">
	<caption>User Statistics</caption>
		<tr>
			<td>No. of offers posted: </td>
			<td><%=MySQL.countOffer(c, uid) %></td>
		</tr>
		<tr>
			<td>No. of rides offered:</td>
			<td><%= MySQL.countRide(c, uid, "D") %></td>
		</tr>
		<tr>
			<td>Driver rating</td>
			<td><%=MySQL.rating(c, uid, "D") %></td>
		</tr>
		<tr>
			<td>No. of requests posted:</td>
			<td><%= MySQL.countRequest(c, uid) %></td>
		</tr>
		<tr>
			<td>No. of rides received:</td>
			<td><%=MySQL.countRide(c, uid, "P") %></td>
		</tr>
		<tr>
			<td>Passenger rating:</td>
			<td><%=MySQL.rating(c, uid, "P") %></td>
		</tr>
	</table>
	<%

}
catch(Exception e) {
	out.println(e);
}
%>

</body>
</html>