<!-- needs to refine:
1. lot selection options should display based on the results of campus selection
2. date picker valid values should be constrained from today to future dates
3. timef valid values should be constrained from now to future
4. timet valid values should be constrained from timef result to future
5. passenger valid values should be between 1 and cars.capacity

now should only take input manually satisfying constrains...
 -->

<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<script type="text/javascript" src="jquery/jquery.js"></script>
<script type="text/javascript" src="jquery/jquery-ui.js"></script>
<link type="text/css" rel="stylesheet" href="jquery/jquery-ui.css" />
<script type="text/javascript">
	$(function(){
		$("#date").datepicker({
			dateFormat: "yy-mm-dd"
		});
	});
</script>

<script type="text/javascript" src="jquery-ui-timepicker-0.3.3/jquery.ui.timepicker.js"></script>
<link type="text/css" rel="stylesheet" href="jquery-ui-timepicker-0.3.3/jquery.ui.timepicker.css" />
<script type="text/javascript">
	$(function(){
		$("#timef").timepicker();
		$("#timet").timepicker();
	});
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post Ride Offer</title>
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
	out.println("welcome, " + session.getAttribute("userId")); %>
	
	<a href="mainUserDashboardPage.jsp">Back to main dashboard</a>
	<form action="logout.jsp" method="post">
	<input type="submit" value="Logout"  id="logout">
	</form>
	
	<% 
	try{
		Connection c = MySQL.connect();
		String sql = null;
	
		%>
		<form action="postRideOffer.jsp" method="post">
		<table align="center" cellpadding="7" cellspacing="2" border="0">
			<caption>Post A Ride Offer</caption>
			<tr>
				<td><label for="campusd">Departure campus</label></td>
				<td><select name="campusd" id="campusd">
			<% sql = "select distinct campus from locations";
				PreparedStatement st = c.prepareStatement(sql);
				ResultSet rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>		
					</select>
				</td>
			</tr>
			<tr>
				<td><label for="lotd">Departure lot</label></td>
				<td><select name="lotd" id="lotd">
			<% sql = "select distinct lot from locations";
				st = c.prepareStatement(sql);
				rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>
					</select>
				</td>
			</tr>
			<tr>
				<td><label for="campusa">Destination campus</label></td>
				<td><select name="campusa" id="campusa">
			<% sql = "select distinct campus from locations";
				st = c.prepareStatement(sql);
				rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>		
					</select>
				</td>
			</tr>
			<tr>
				<td><label for="lota">Destination lot</label></td>
				<td><select name="lota" id="lota">
			<% sql = "select distinct lot from locations";
				st = c.prepareStatement(sql);
				rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>
					</select>
				</td>
			</tr>
			<tr>
				<td><label for="date">Departure date</label></td>
				<td><input type="text" name="date" id="date"/></td>
			</tr>
			<tr>
				<td><label for="timef">Departure time from</label></td>
				<td><input type="text" name="timef" id="timef" /></td>
			</tr>
			<tr>
				<td><label for="timet">Departure time to</label></td>
				<td><input type="text" name="timet" id="timet" /></td>
			</tr>
			<tr>
				<td><label for="car">Car</label></td>
				<td><select name="car" id="car">
			<% sql = "select plate from cars where uid=?";
				st = c.prepareStatement(sql);
				st.setString(1, session.getAttribute("userId").toString());
				rs = st.executeQuery();
				while(rs.next()) { %>
					<option><%= rs.getString(1) %></option>
			<% 	}%>
		
					</select>
				</td>
			</tr>
			<tr>
				<td><label for="passenger">Number of passengers I can take</label></td>
				<td><select name="passenger" id="passenger">
					<option value=1>1</option>
					<option value=2>2</option>
					<option value=3>3</option>
					<option value=4>4</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><label for="regular">Is this offer regular?</label></td>
				<td><input type="radio" name="regular" value="Y">Yes
					<input type="radio" name="regular" value="N" checked>No
				</td>
			</tr>
		</table>
		<br>
		<div align="center"><input type="submit" value="Post offer" /></div>
		
		</form>
		<%
	}
	catch (Exception e){
		out.println(e);
	}
}
%>
</body>
</html>