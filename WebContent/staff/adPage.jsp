<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Advertisement Management</title>
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
	<a href="staffHomePage.jsp">Back to home page</a>
	<form action="logout.jsp" method="post">
		<input type="submit" value="Logout"/>
	</form>
	
	<table align="center" cellpadding="7" cellspacing="2" border="1">
	<caption>Advertisements</caption>
	<tr>
	<td>aid</td><td>Name</td><td>Url</td><td>Reward</td><td>Count</td><td>Edit</td><td>Remove</td>
	</tr>
	
	<%
	try {
		Connection c = MySQL.connect();
		String sql = "select * from ads";
		PreparedStatement st = c.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		while(rs.next()) {
			%>
			<tr>
				<td><%=rs.getInt("aid") %></td>
				<td><%=rs.getString("name") %></td>
				<td><%=rs.getString("url") %></td>
				<td><%=rs.getInt("reward") %></td>
				<td><%=rs.getInt("count") %></td>
				<td>
					<form action="editAdPage.jsp">
					<input type="hidden" name="aid" value=<%=rs.getInt("aid") %>>
					<input type="submit" value="edit">
					</form>
				</td>
				<td>
					<form action="deleteAd.jsp">
					<input type="hidden" name="aid" value=<%=rs.getInt("aid") %>>
					<input type="submit" value="delete">
					</form>
				</td>
			</tr>
			<%} %>
		</table>
		
		
		<br>
		<br>
		<form action="addAd.jsp" method="post">
		<table align="center" cellpadding="7" cellspacing="2">
		<tr>
		<td><label for="name">Ad Name</label></td>
		<td><input type="text" name="name"></td>
		</tr>
		<tr>
		<td><label for="url">Ad Url</label></td>
		<td><input type="text" name="url"></td>
		</tr>
		<tr>
		<td><label for="url">Ad Reward</label></td>
		<td><input type="radio" name="reward" value=1 checked>1
		<%for(int i = 2; i < 6; i ++) {
			%><input type="radio" name="reward" value=<%=i%>><%=i%>
			<%} %>
		</td>
		</tr>
		<tr>
		<td></td>
		<td><input type="submit" value="Add"></td>
		</tr>
		</table>
		</form>
			<% 
		
	}
	catch(Exception e) {
		out.print(e);
	}
} %>

</body>
</html>