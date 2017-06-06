<%@page import = "jsp.*, java.sql.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String email = request.getParameter("email");
Connection c = MySQL.connect();
String sql = "select uid from users where email=?";
PreparedStatement st = c.prepareStatement(sql);
st.setString(1, email);
ResultSet rs = st.executeQuery();
if(rs.next()) {
	String text = "Your user ID is " + rs.getString("uid");
	String subject = "RideShare Password";
	Email mail = new Email();
	mail.send(email, subject, text);
	%>
	<p>User ID has been sent to <%=email %></p>
	<%
	
}
else {
	%>
	<p>Email address is not found!</p>
	<%
}

%>
<p><a href="loginPage.jsp">Back to login page</a></p>

</body>
</html>