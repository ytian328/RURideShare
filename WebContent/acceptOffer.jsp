<%@ page import="java.sql.*, jsp.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Accept Offer</title>
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
	out.println("welcome, " + session.getAttribute("userId")); %>
	
	<a href="mainUserDashboardPage.jsp">Back to main dashboard</a>
	<form action="logout.jsp" method="post">
	<input type="submit" value="Logout"  id="logout">
	</form> <%

	String mid = request.getParameter("accept");
	//set match status as CFM
	//set offer status as CFM
	//set request status as CFM
	Connection c = MySQL.connect();
	
	
	String mSql = "select rid, oid from matches where mid=?";
	PreparedStatement mSt = c.prepareStatement(mSql);
	mSt.setInt(1, Integer.parseInt(mid));
	ResultSet rs = mSt.executeQuery();
	if(rs.next()) {
		String rCfmSql = "update requests set status='CFM' where rid=?";
		PreparedStatement rCfmSt = c.prepareStatement(rCfmSql);
		rCfmSt.setInt(1, rs.getInt("rid"));
		rCfmSt.executeUpdate();
		
		String oCfmSql = "update offers set status='CFM' where oid=?";
		PreparedStatement oCfmSt = c.prepareStatement(oCfmSql);
		oCfmSt.setInt(1, rs.getInt("oid"));
		oCfmSt.executeUpdate();
		
		String mCfmSql = "update matches set status='CFM' where mid=?";
		PreparedStatement mCfmSt = c.prepareStatement(mCfmSql);
		mCfmSt.setInt(1, Integer.parseInt(mid));
		mCfmSt.executeUpdate();
	}
	%>
	<div>
		<p>Your trip <%= mid%> is confirmed! Please go to <a href="passengerOrdersPage.jsp">passenger orders</a> to manage your orders</p>
		<p>#####################I am ads######################</p>
	</div>
	<%

}
catch(Exception e) {
	out.println(e);
}
%>

</body>
</html>