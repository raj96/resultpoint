package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.SubmitDao;

public class SubmitInfo {
	SubmitDao dao;
	Connection con;
	
	public SubmitInfo(SubmitDao dao) {
		this.dao = dao;
		con = OracleConnection.getConnection();
	}
	
	public boolean submit() {
		PreparedStatement ps;
		String query = "INSERT INTO user_info2 VALUES(?,?,?,?,?,?,?,?,?,?)";
		try{
			ps = con.prepareStatement(query);
			ps.setString(1,dao.getFathers_name());
			ps.setString(2,dao.getMothers_name());
			ps.setString(3,dao.getFathers_occ());
			ps.setString(4,dao.getMothers_occ());
			ps.setString(5,dao.getCurr_addr());
			ps.setString(6,dao.getPerm_addr());
			ps.setString(7,dao.getMobile_no());
			ps.setString(8,dao.getGuardians_name());
			ps.setString(9,dao.getPmobile_no());
			ps.setString(10, dao.getEmail());
			
			return ps.executeUpdate()>0;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
}
