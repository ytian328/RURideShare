<%@page import = "jsp.*, java.sql.*, java.util.* " %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>add a car</title>
</head>
<body>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

String make = request.getParameter("make");
String model = request.getParameter("model");
String year = request.getParameter("year");
String color = request.getParameter("color");
String capacity = request.getParameter("capacity");
String plate = request.getParameter("plate");

if(plate == null || model == null || color == null || make == null || 
	plate.equals("") || model.equals("") || color.equals("") || make.equals("")){
	response.sendRedirect("myAccountPage.jsp");
}

else if(session.getAttribute("userId") == null) {
	out.println("login first");
	%>
	<a href="loginPage.jsp">Log in</a>
	<%
}
else try{
	Connection c = MySQL.connect();
	
	String chkSql = "select uid from cars where plate=?";
	PreparedStatement chkSt = c.prepareStatement(chkSql);
	chkSt.setString(1, request.getParameter("plate"));
	ResultSet chkRs = chkSt.executeQuery(); 
	if(chkRs.next()) {
		if (! chkRs.getString("uid").equals(session.getAttribute("userId").toString())) {
			response.sendRedirect("myAccountPage.jsp");
		}
		else {
			String updateSql = "update cars set make=?, model=?, year=?, color=?, capacity=?, status='ACT' where plate=?";
			PreparedStatement updateSt = c.prepareStatement(updateSql);
			updateSt.setString(1, make);
			updateSt.setString(2, model);
			updateSt.setString(3, year);
			updateSt.setString(4, color);
			updateSt.setString(5, capacity);
			updateSt.setString(6, plate);
			updateSt.execute();
		}
	}
	else {
		String insertSql = "insert into cars (plate, make, model, year, color, capacity, uid) values (?,?,?,?,?,?,?)";
		PreparedStatement insertSt = c.prepareStatement(insertSql);
		insertSt.setString(1, plate);
		insertSt.setString(2, make);
		insertSt.setString(3, model);
		insertSt.setString(4, year);
		insertSt.setString(5, color);
		insertSt.setString(6, capacity);
		insertSt.setString(7, session.getAttribute("userId").toString());
		insertSt.execute();
	}
	response.sendRedirect("myAccountPage.jsp");
	
}
catch (Exception e){
	out.print(e);
}

%>
</body>
</html>