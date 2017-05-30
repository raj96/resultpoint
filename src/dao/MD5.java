package dao;

import java.math.BigInteger;
import java.security.MessageDigest;

public class MD5 {
	public static String md5(String data) {
		try {
			MessageDigest m=MessageDigest.getInstance("MD5");
			m.update(data.getBytes(),0,data.length());
			System.out.println("MD5");
			return (new String(new BigInteger(1,m.digest()).toString(16)));
		}
		catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		
		
	}
}
