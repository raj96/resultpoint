package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ChangePassword {
	String oldPass,newPass,email;
	
	public ChangePassword(String opass,String npass,String email) {
		this.oldPass = opass;
		this.newPass = npass;
		this.email = email;
	}
	
	public boolean change() {
		Connection con = OracleConnection.getConnection();
		try {
			String query = "SELECT email FROM user_info WHERE (pass=? AND email=?)";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, oldPass);
			ps.setString(2, email);
			
			ResultSet rs = ps.executeQuery();
			
			if(!rs.next())
				throw new Exception();
			
			query = "UPDATE user_info SET pass=? WHERE email=?";
			ps = con.prepareStatement(query);
			ps.setString(1, newPass);
			ps.setString(2, email);
			
			if(ps.executeUpdate()>0)
				return true;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return false;
	}

}
