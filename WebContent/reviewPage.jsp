<%@page import = "jsp.*, java.sql.* " %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Review</title>
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
	out.println("welcome, " + session.getAttribute("userId"));
%>
	<a href="mainUserDashboardPage.jsp">Back to main dashboard</a>
	<form action="logout.jsp" method="post">
		<input type="submit" value="Logout"/>
	</form>
<%
	String mid=request.getParameter("mid");
	String role = request.getParameter("role");
	
	try {
		Connection c = MySQL.connect();
		String pSql = "select * from reviews where mid=? and role='p'";
		PreparedStatement pSt = c.prepareStatement(pSql);
		pSt.setInt(1, Integer.parseInt(mid));	
		ResultSet pRs = pSt.executeQuery();
		
		if(pRs.next()) {
			//display passenger review
			String pRating = pRs.getString("rating");
			String pComm = pRs.getString("comm");
			String rtime = pRs.getString("rtime");
			%>
			<p>Passenger's Review</p>
			<p>Rating: <%=pRating %> </p>
			<p><%=rtime %> </p>
			<%
			if(pComm != null) {
				%>
				<p><%=pComm %></p>
				<% 
			}

			
		}
		else if(role.equals("p")){
			//passenger write review
			out.println("Passenger please review this trip:");
			%>
			<form action="insertReview.jsp" method="post">
				<p>Rate this trip: 
					<input type="radio" name="rating" value=1> 1
					<input type="radio" name="rating" value=2> 2
					<input type="radio" name="rating" value=3> 3
					<input type="radio" name="rating" value=4> 4
					<input type="radio" name="rating" value=5 checked> 5 </p>
				<p>      
					<textarea name="comment" rows="6" cols="50" maxlength="300">Comment here...</textarea>
					<input type="hidden" name="role" value="p">
					<input type="hidden" name="mid" value=<%=mid %>>
				</p>
				<p><input type="submit" value="Submit"></p> 
			</form>			
			<% 
			
		}
		else {
			//display no passenger review info
			out.println("The passenger has not rated this trip yet!");
		}
		
		String dSql = "select * from reviews where mid=? and role='d'";
		PreparedStatement dSt = c.prepareStatement(dSql);
		dSt.setInt(1, Integer.parseInt(mid));	
		ResultSet dRs = dSt.executeQuery();
		if(dRs.next()) {
			//display driver review
			String dRating = dRs.getString("rating");
			String dComm = dRs.getString("comm");
			String rtime = dRs.getString("rtime");
			%>
			<p>Driver's Review</p>
			<p>Rating: <%=dRating %> </p>
			<p><%=rtime %> </p>
			<%
			if(dComm != null) {
				%>
				<p><%=dComm %></p>
				<% 
			}
			
		}
		else if(role.equals("d")){
			//driver write review
			out.println("Driver please review this trip:");
			%>
			<form action="insertReview.jsp" method="post">
				<p>Rate this trip: 
					<input type="radio" name="rating" value=1> 1
					<input type="radio" name="rating" value=2> 2
					<input type="radio" name="rating" value=3> 3
					<input type="radio" name="rating" value=4> 4
					<input type="radio" name="rating" value=5 checked> 5 </p>
				<p>      
					<textarea name="comment" rows="6" cols="50" maxlength="300">Comment here...</textarea>
					<input type="hidden" name="role" value="d">
					<input type="hidden" name="mid" value=<%=mid%>>
				</p>
				<p><input type="submit" value="Submit"></p> 
			</form>			
			<% 
			
		}
		else {
			//display no driver review info
			out.println("The driver has not rated this trip yet!");
		}
		
		if(role.equals("p")) {
			%><a href="passengerOrderHistoryPage.jsp">Back</a><%
		}
		else {
			%><a href="driverOrderHistoryPage.jsp">Back</a><%
		}
		
		
	}
	catch (Exception e) {
		out.print(e);
	}
}
%>

</body>
</html>