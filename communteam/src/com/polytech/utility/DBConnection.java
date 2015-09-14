package com.polytech.utility;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

public class DBConnection extends Encoding{
	static{
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	String url = "jdbc:oracle:thin:@192.168.18.247:1521:orcl";
	String DBid = "commun";
	String DBpwd = "teamcommun";
	
	protected Connection con;
	protected PreparedStatement pstmt;
	protected ResultSet rs;
	
	public void dbConn(String sql){
		try{
		con = DriverManager.getConnection(url, DBid, DBpwd);
		pstmt = con.prepareStatement(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void dbClose(){
		try{
			if(rs!=null) con.close();
			if(pstmt!=null) con.close();
			if(con!=null) con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
