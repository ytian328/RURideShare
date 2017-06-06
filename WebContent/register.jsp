<%@page import = "jsp.*, java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>
	<%
	//get register user info
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String email = request.getParameter("email");
	String email2 = request.getParameter("email2");
	if(email2.length() == 0) email2 = email;
	String userId = request.getParameter("userId");
	String pwd = request.getParameter("pwd");
	String pwd2 = request.getParameter("pwd2");
	String pub = request.getParameter("pub");
	//get car info
	String maker= request.getParameter("maker");
	String mdl = request.getParameter("mdl");
	String yr = request.getParameter("yr");
	String clr = request.getParameter("clr");
	String psgr = request.getParameter("psgr");
	String plt = request.getParameter("plt");
	boolean validIDEmail = true;
	//check userid and email are unique
	try{
		Connection c = MySQL.connect();
		String sql = "select uid, email from users";
		PreparedStatement st = c.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		while(rs.next()) {
			if(rs.getString("uid").equals(userId)) {
				out.print("User ID has been registered!");
				validIDEmail = false;
				break;
			}
			if(rs.getString("email").equals(email)){
				out.print("Email address has been registered!");
				validIDEmail = false;
				break;
			}
		}
		
	}
	catch(SQLException e) {
		out.println("SQLException: " + e.getMessage());
	}
	if(validIDEmail && !pwd.equals(pwd2)) {
		out.print("Password does not match!");
	}
	else if(validIDEmail && !Validation.validEmail(email)) {
		out.print("Email address is not valid!");
	}
	else if(validIDEmail && ! Validation.validPassword(pwd)) {
		out.print("Password is not valid");
	}
	else if(validIDEmail) try{
		Connection c = MySQL.connect();
	
		String sql = "insert into users (uid, fname, lname, email, email2, pwd, public, nreward, treward) values (?,?,?,?,?,?,?,?,?)";
		PreparedStatement st = c.prepareStatement(sql);
		st.setString(1, userId);
		st.setString(2, fname);
		st.setString(3, lname);
		st.setString(4, email);
		st.setString(5, email.equals(email2) || email2.equals("") ? email: email2);
		st.setString(6, pwd);
		st.setString(7, pub);
		st.setString(8, "0");
		st.setString(9, "0");
		
		st.executeUpdate();
		
		if(!plt.equals("") && !psgr.equals("")) {
			sql = "insert into cars (plate, make, model, year, color, capacity, uid) value (?,?,?,?,?,?,?)";
			st = c.prepareStatement(sql);
			st.setString(1, plt);
			st.setString(2, maker);
			st.setString(3, mdl);
			st.setString(4, yr);
			st.setString(5, clr);
			st.setString(6, psgr);
			st.setString(7, userId);
			st.executeUpdate();
		} 
		out.println("You are successfully registered! ");
		
	} catch(SQLException e) {
		out.println("SQLException: " + e.getMessage());
	} 

	%>
	<a href="index.html">Home</a>
</body>
</html>