<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
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
	
	<a href="mainUserDashboard.html">Back to main dashboard</a>
	<form action="logout.jsp" method="post">
	<input type="submit" value="Logout"  id="logout">
	</form>
	
	<% 
	try{
		Connection c = MySQL.connect();
		String sql = null;
	
		%>
		<form action="postRideOffer.jsp" method="post">
			<label for="campusd">Departure campus</label>
			<select name="campusd" id="campusd">
			<% sql = "select distinct campus from locations";
				PreparedStatement st = c.prepareStatement(sql);
				ResultSet rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>		
			</select>
			<label for="lotd">Departure lot</label>
			<select name="lotd" id="lotd">
			<% sql = "select distinct lot from locations";
				st = c.prepareStatement(sql);
				rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>
			</select>
			
			<label for="campusa">Destination campus</label>
			<select name="campusa" id="campusa">
			<% sql = "select distinct campus from locations";
				st = c.prepareStatement(sql);
				rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>		
			</select>
			<label for="lota">Destination lot</label>
			<select name="lota" id="lota">
			<% sql = "select distinct lot from locations";
				st = c.prepareStatement(sql);
				rs = st.executeQuery();
				while(rs.next()) {%>
				<option><%= rs.getString(1) %></option>
			<% 	}%>
			</select>
			<br>
			<br>
			<label for="date">Departure date</label>
			<input type="text" name="date" id="date"/>
			<label for="timef">Departure time from</label>
			<input type="text" name="timef" id="timef" />
			<label for="timet">Departure time to</label>
			<input type="text" name="timet" id="timet" />
			<br>
			<br>
			<label for="car">Car</label>
			<select name="car" id="car">
			<% sql = "select plate from cars where user_id=?";
				st = c.prepareStatement(sql);
				st.setString(1, session.getAttribute("userId").toString());
				rs = st.executeQuery();
				while(rs.next()) { %>
					<option><%= rs.getString(1) %></option>
			<% 	}%>
		
			</select>
			<br>
			<br>
			<label for="passenger">Number of Passengers I can take</label>
			<select name="passenger" id="passenger">
				<option value=1>1</option>
				<option value=2>2</option>
				<option value=3>3</option>
				<option value=4>4</option>
			</select>
			<br>
			<br>
			<input type="submit" value="Post offer"/>
		
		
		</form>
		<%
	}
	catch (Exception e){
		
	}
}

%>

</body>
</html>