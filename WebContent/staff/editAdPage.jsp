<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Ad</title>
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
	int aid = Integer.parseInt(request.getParameter("aid"));
	Connection c = MySQL.connect();
	String sql = "select * from ads where aid=?";
	PreparedStatement st = c.prepareStatement(sql);
	st.setInt(1, aid);
	ResultSet rs = st.executeQuery();
	if(rs.next()) {
		%>
		<form action="updateAd.jsp" method="post">
		<table>
		<tr>
		<td>aid</td>
		<td><%=aid %></td>
		</tr>
		<tr>
		<td>Name</td>
		<td><%=rs.getString("name") %></td>
		</tr>
		<tr>
		<td><label for="url">Url</label></td>
		<td><input type="text" name="url" value=<%=rs.getString("url") %>></td>
		<tr>
		<td><label for="url">Ad Reward</label></td>
		<td><input type="radio" name="reward" value=1 checked>1
		<%for(int i = 2; i < 6; i ++) {
			%><input type="radio" name="reward" value=<%=i%>><%=i%>
			<%} %>
		</td>
		</tr>
		<tr>
		<td><input type="hidden" name="aid" value=<%=aid %>></td>
		<td><input type="submit" value="update"></td>
		</tr>
		</table>
		</form>
		<% 
	}
}
catch(Exception e) {
	out.print(e);
}
%>

</body>
</html>