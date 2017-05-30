package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.SigninDao;

public class SignIn {
	SigninDao dao;
	Connection con;
	private int USER_OK 			= 1,
				FORM2_NOT_FILLED 	= 2,
				CRED_ERROR 			= 3,
				USER_DOES_NOT_EXIST = 4,
				UNKNOWN_ERROR		= 5;
	
	public SignIn(SigninDao dao) {
		this.dao = dao;
		con = OracleConnection.getConnection();
	}
	
	public int checkSignIn() {
		PreparedStatement 	ps = null,
							ps1 = null;
		final String query1 = "SELECT pass,name FROM user_info WHERE email=?";
		final String query2 = "SELECT email FROM user_info2 WHERE email=?";
		
		try{
			//Check credential and if user exists
			ps = con.prepareStatement(query1);
			ps1 = con.prepareStatement(query2);
			
			ps.setString(1, dao.getEmail());
			ps1.setString(1, dao.getEmail());
			
			ResultSet rs = ps.executeQuery();
			ResultSet rs2 = ps1.executeQuery();
			rs.next();
			rs2.next();
			
			try {
				String name = rs.getString("name");
				dao.setName(name);
			}
			catch(Exception e){
				return USER_DOES_NOT_EXIST;
			}
			
			final String pass = rs.getString("pass");
			if(!pass.equals(dao.getPassword()))
				return CRED_ERROR;
			
			try {
				rs2.getString("email");
			}
			catch(Exception e) {
				return FORM2_NOT_FILLED;
			}
			
			return USER_OK;
		}	
		catch(Exception e){
			e.printStackTrace();
			return UNKNOWN_ERROR;
		}
	}
}
