<%@page import =" java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/postStyle.css">
<title>Register</title>
</head>
<body>

<body>
<form action="register.jsp" method="post">
<table align="center" cellpadding="7" cellspacing="2" border="0" width = "400">
<caption>Register A New Account</caption>
	<tr>
		<td><label for="fname">First Name</label></td>
		<td><input type="text" name="fname" id="fname" maxlength=20/></td>
	</tr>
	<tr>
		<td><label for="lname">Last Name</label></td>
		<td><input type="text" name="lname" id="lname" maxlength=20/></td>
	</tr>
	<tr>
		<td><label for="email">Email</label></td>
		<td><input type="text" name="email" id="email" maxlength=40/></td>
	</tr>
	<tr>
		<td><label for="email2">Secondary Email for Messages</label></td>
		<td><input type="text" name="email2" id="email2" maxlength=40/></td>
	</tr>
	<tr>
		<td><label for="userId">User Name</label></td>
		<td><input type="text" name="userId" id="userId" maxlength=10/></td>
	</tr>
	<tr>
		<td><label for="pwd">Password</label></td>
		<td><input type="password" name="pwd" id="pwd" maxlength=20/></td>
	</tr>
	<tr>
		<td><font size="1" color="red">Password should be 6-20 letters long, containing both alphabets and digits.</font></td>
	</tr>
	
	<tr>
		<td><label for="pwd2">Confirm Password</label></td>
		<td><input type="password" name="pwd2" id="pwd2" maxlength=20/></td>
	</tr>
	<tr>
		<td><label for="pub">Do you want your info. public?</label></td>
		<td><input type="radio" name="pub" value="Y" id="pub">Yes
			<input type="radio" name="pub" value="N" id="pub">No</td>
	</tr>
</table>
<br>
<table align="center" cellpadding="7" cellspacing="2" border="0" width = "400">	
<caption>Car Information (optional)</caption>
	<tr>
		<td><label for="maker">Maker</label></td>
		<td><input type="text" name="maker" id="maker" maxlength=20></td>
	</tr>
	<tr>
		<td><label for="mdl">Model</label></td>
		<td><input type="text" name="mdl" id="mdl" maxlength=20></td>
	</tr>
	<tr>
		<td><label for="yr">Year of Made</label></td>
		<td><select name="yr" id="yr">
		<% Calendar calendar = new GregorianCalendar();
		int year = calendar.get(Calendar.YEAR); 
		int i = 0;
		while(i < 20) {%>
		<option><%= year - i++ %></option><%	
		}%>
		</select></td>
	</tr>
	<tr>
		<td><label for="clr">Color</label></td>
		<td><input type="text" name="clr" id="clr" maxlength=10></td>
	</tr>
	<tr>
		<td><label for="psgr">Max No. of Passengers</label></td>
		<td><select name="psgr" id="psgr">
			<option>1</option>
			<option>2</option>
			<option>3</option>
			<option>4</option>
		</td>
	</tr>
	<tr>
		<td><label for="plt">Plate No.</label></td>
		<td><input type="text" name="plt" id="plt" maxlength=10></td>
	</tr>
</table>
<br>
<p align="center"><input type="submit" name="submit" value="register" id="reg"></p>
</form>

</body>
</html>