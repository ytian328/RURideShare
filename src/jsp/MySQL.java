package jsp;

import java.math.BigDecimal;
import java.sql.*;

public class MySQL {
	public static Connection connect() {
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			return DriverManager.getConnection("jdbc:mysql://localhost:3306/test?autoReconnect=true&useSSL=false", "root", "root");
		}
		catch (Exception e){
			throw new Error(e);
		}
		
	}
	
	public static boolean close(Connection c){
		try {
			c.close();
			return true;
		}
		catch(Exception e) {
			return false;
		}
	}
	
	public static int countOffer(Connection c, String uid) throws SQLException {
		String sql = "select count(*) as ct from offers where did=?";
		PreparedStatement st = c.prepareStatement(sql);
		st.setString(1, uid);
		ResultSet rs = st.executeQuery();
		if(rs.next()) {
			return rs.getInt("ct");
		} 
		else {
			return 0;
		}
	}
	
	public static int countRequest(Connection c, String uid) throws SQLException {
		String sql = "select count(*) as ct from requests where pid=?";
		PreparedStatement st = c.prepareStatement(sql);
		st.setString(1, uid);
		ResultSet rs = st.executeQuery();
		if(rs.next()) {
			return rs.getInt("ct");
		} 
		else {
			return 0;
		}
	}
	
	public static int countRide(Connection c, String uid, String role) throws SQLException {
		String sql = "";
		if(role.equals("P")) {
			sql = "select count(m.mid) as ct from matches m, requests r where r.pid=? and r.rid=m.rid and m.status='FNS'";
		}
		else if(role.equals("D")) {
			sql = "select count(m.mid) as ct from matches m, offers o where o.did=? and o.oid=m.oid and m.status='FNS'";
		}
		else {
			return 0;
		}
		PreparedStatement st = c.prepareStatement(sql);
		st.setString(1, uid);
		ResultSet rs = st.executeQuery();
		if(rs.next()) {
			return rs.getInt("ct");
		} 
		else {
			return 0;
		}
	}
	
	public static float rating(Connection c, String uid, String role) throws SQLException {
		String sql ="";
		if(role.equals("P")) {
			sql ="select v.rating from reviews v, matches m, requests r where r.pid=? and r.rid= m.rid and m.mid=v.mid and v.role='D'";
		}
		else if(role.equals("D")) {
			sql = "select v.rating from reviews v, matches m, offers o where o.did=? and o.oid= m.oid and m.mid=v.mid and v.role='P'";
		}
		PreparedStatement st = c.prepareStatement(sql);
		st.setString(1, uid);
		ResultSet rs = st.executeQuery();
		int count = 0;
		float sum = 0;
		while(rs.next()){
			count ++;
			sum += rs.getInt("rating");
		}
		if(count == 0) return 0;
		BigDecimal bd = new BigDecimal(Float.toString(sum/count));
		return bd.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
	}

}
