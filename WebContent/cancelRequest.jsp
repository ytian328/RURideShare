<%@ page import="java.sql.*, jsp.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel active request</title>
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
	//1. mark the entry in requests table as CNL
	//2. if someone send offer to this entry, it will appear in matches table.
	//needs to delete these matches and set the corresponding offer ACT depending on current time
	String rid = request.getParameter("cancel");
	Connection c = MySQL.connect();
	String markCnl = "update requests set status='CNL' where rid=?";
	PreparedStatement markCnlSt = c.prepareStatement(markCnl);
	markCnlSt.setInt(1, Integer.parseInt(rid));
	markCnlSt.executeUpdate();

	String srchMatch = "select mid, oid from matches where rid=?";
	PreparedStatement srchMatchSt = c.prepareStatement(srchMatch);
	srchMatchSt.setInt(1, Integer.parseInt(rid));
	ResultSet rs = srchMatchSt.executeQuery();
	while(rs.next()) {
		String delMatch = "delete from matches where mid=?";
		PreparedStatement delMatchSt = c.prepareStatement(srchMatch);
		delMatchSt.setInt(1, rs.getInt("mid"));
		delMatchSt.execute();
		
		String markAct = "update offers set status='ACT' where oid=?";
		PreparedStatement markActSt = c.prepareStatement(srchMatch);
		markActSt.setInt(1, rs.getInt("oid"));
		markActSt.execute();
	}
	response.sendRedirect("requestListPage.jsp");
}
catch(Exception e) {
	out.println(e);
}
%>

</body>
</html>