<%@page import = "jsp.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Finish order</title>
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
	try{
		int mid = Integer.parseInt(request.getParameter("mid"));
		String returnPage = request.getParameter("returnPage");
		Connection c = MySQL.connect();
		String sql = "update matches set status='FNS' where mid=?";
		PreparedStatement st = c.prepareStatement(sql);
		st.setInt(1, mid);
		st.execute();
		
		sql = "select u.uid, u.treward from users u, matches m, offers o where m.mid=? and o.oid=m.oid and o.did=u.uid";
		st = c.prepareStatement(sql);
		st.setInt(1, mid);
		ResultSet rs = st.executeQuery();
		if(rs.next()) {
			int nReward = 1;
			sql = "update users set treward=?, nreward=? where uid=?";
			st = c.prepareStatement(sql);
			st.setInt(1, rs.getInt("u.treward") + nReward);
			st.setInt(2, nReward);
			st.setString(3, rs.getString("u.uid"));
			st.execute();
		}
		
				
		response.sendRedirect(returnPage);
	}
	catch(Exception e) {
		out.print(e);
	}
}
%>

</body>
</html>