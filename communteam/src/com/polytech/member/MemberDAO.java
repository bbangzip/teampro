package com.polytech.member;

import java.util.ArrayList;
import java.util.List;

import com.polytech.utility.DBConnection;

public class MemberDAO extends DBConnection{
	//우편번호 검색
	public List<MemberVO> zipcodeSearch(MemberVO mv){
		List<MemberVO> lst = new ArrayList<MemberVO>();
		try{
			String sql = "select * from zipTbl where doro like '%"+mv.getAddr1()+"%'";
			dbConn(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVO mv2 = new MemberVO();
				mv2.setZipCode(rs.getString("zipcode"));
				String addr1 = rs.getString("sido")+rs.getString("sigungu");
				addr1+=" "+rs.getString("doro")+" ";
				
				String bName = rs.getString("bName");
				if(bName != null){addr1 += bName;}
				
				addr1 +="("+rs.getString("dong")+")";
				
				 
				mv2.setAddr1(addr1);
				mv2.setAddr2(rs.getInt("zibun") +"~"+ rs.getInt("zibun2"));
				
				lst.add(mv2);
			}	
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return lst;
	}
}



