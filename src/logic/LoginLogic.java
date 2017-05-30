package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.LoginDao;

public class LoginLogic {
	LoginDao dao;
	Connection con;
	public LoginLogic(LoginDao dao) {
		this.dao = dao;
		con = OracleConnection.getConnection();
		System.out.println(con);
	}
	
	public boolean insertData() {
		PreparedStatement stat = null;
		String sql = "INSERT INTO TEST VALUES(?,?)";
		int result;
		System.out.println(dao.getPass());
		if(dao.getPass().equals("select")) {
			ResultSet rs = null;
			String sel_query = "SELECT * FROM test  WHERE email=? and pass=?";
			
			try {
				stat = con.prepareStatement(sel_query);
				stat.setString(1, dao.getEmail());
				stat.setString(2, dao.getPass());
				
				rs = stat.executeQuery();
				
				while(rs.next()) {
					System.out.println("Email: "+rs.getString(1)+" Password: "+rs.getString(2));
					if(dao.getEmail().equals(rs.getString(1)) && dao.getPass().equals(rs.getString(2)))
						return true;
				}
			}
			catch(Exception e) {
				e.printStackTrace();
				return false;
			}
			
			
		}
		
		try {
			stat = con.prepareStatement(sql);
			stat.setString(1, dao.getEmail());
			stat.setString(2, dao.getPass());
			result = (stat.executeUpdate()>0)?1:0;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return result==1;
	}
	
	public boolean checkPasswordisNull() {
		if(dao.getPass().isEmpty()) 
			return true;
		return false;
	}
}
