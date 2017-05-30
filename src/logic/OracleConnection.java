package logic;

import java.sql.DriverManager;
import java.sql.Connection;

public class OracleConnection {

	public static Connection  getConnection() {
		Connection con = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","123456");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
}
