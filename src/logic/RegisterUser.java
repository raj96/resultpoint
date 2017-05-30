package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;

import dao.RegisterDao;

public class RegisterUser {
	RegisterDao dao;
	Connection con;
	
	public RegisterUser(RegisterDao rd) {
		this.dao = rd;
		con = OracleConnection.getConnection();
	}
	
	public boolean register() {
		PreparedStatement ps = null;
		final String query = "INSERT INTO user_info VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			ps = con.prepareStatement(query);
			ps.setString(1, dao.getName());
			ps.setString(2,dao.getEmail());
			ps.setString(3,dao.getPasssword());
			ps.setString(4,dao.getGender());
			ps.setString(5,dao.getBday());
			ps.setString(6,dao.getCollege_name());
			ps.setString(7,dao.getDegree_name());
			ps.setString(8,dao.getDept_name());
			ps.setString(9,dao.getSem());
			ps.setString(10,dao.getRoll_no());
			ps.setString(11, LocalDateTime.now().getMonthValue()+"");
			ps.setString(12, LocalDateTime.now().getYear()+"");
			
			if(ps.executeUpdate()>0)
			{
				return true;
			}	
			//return false;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}
}
