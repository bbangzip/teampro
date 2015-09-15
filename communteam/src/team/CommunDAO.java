package team;


import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import team.MemberVO;
import com.polytech.utility.DBConnection;

public class CommunDAO extends DBConnection{

	//로그인 했는지 확인
	public void loginCheck(MemberVO cd){
		try{
			String sql = "select userid, userpwd, username from memberTbl where ";
					sql += "userid=? and userpwd=?";
			dbConn(sql);
			pstmt.setString(1, cd.getUserId());
			pstmt.setString(2, cd.getUserPwd());
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				cd.setUserName(rs.getString(3));
				cd.setLoginCheck("Y");
			}else{
				cd.setLoginCheck("N");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbClose();
		}
	}
	
	//구 가져오기
	public void zipSearch(List<ZipVO> arrayList){
		try{
			String sql2 = "select distinct gu from ziptbl";
			dbConn(sql2);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ZipVO cv = new ZipVO();
				cv.setGu(rs.getString(1));
				arrayList.add(cv);
			}
			
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			try{
				dbClose();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		//return arrayList;
	}
	
	//동 가져오기
	public void zipSearch2(List<ZipVO> arrayList, String gg){
		try{
			String sql = "select distinct dong from ziptbl where gu=?";
					//+ "where=?";
			dbConn(sql);
			pstmt.setString(1,gg);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ZipVO cv = new ZipVO();
				cv.setDong(rs.getString(1));
				arrayList.add(cv);
			}
			
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			try{
				dbClose();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		//return arrayList;
	}
	
	//서버에 동일 아이디 있나 확인
	public boolean idCheck(String id){
		boolean result = false;
		try{
			String sql = "select count(userId) from memberTbl where userId=?";
			dbConn(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getInt(1)>0){
					result=true;
				}
			}
		}catch(Exception e){e.printStackTrace();}
		finally{
			dbClose();			
		}
		return result;
	}
	
	//회원가입하기
	public int insertRecord(MemberVO cv){
		int result=0;
		try{
			String sql="insert into memberTbl values(memSq.nextVal, ?, ?, ?, ?"
					+ ",?, ?,?,'','Y',?)";
			dbConn(sql);
			
			pstmt.setString(1, toKorUTF(cv.getUserName()));
			pstmt.setString(2, cv.getUserId());
			pstmt.setString(3, cv.getUserPwd());
			pstmt.setString(4, cv.getTel1()+"-"+cv.getTel2()+"-"+cv.getTel3());
			pstmt.setString(5, cv.getZipCode());
			pstmt.setString(6, toKorUTF(cv.getAddr1()));
			pstmt.setString(7, toKorUTF(cv.getAddr2()));
			pstmt.setString(8, cv.getEmail());
		
			result = pstmt.executeUpdate();
		}catch(Exception e){e.printStackTrace();}		
		finally{
			dbClose();			
		}
		return result;
	}
	
	//내지역 체크한 회원 수 가져오기
	public int getLocal(String dong){
		int cnt=0;
		try{
			String sql= "select distinct count(userid) from membertbl where mylocal like '%'||?||'%'";
			dbConn(sql);
			pstmt.setString(1, dong);
			rs= pstmt.executeQuery();
			
			if(rs.next()){
				cnt=rs.getInt(1);
			}
		}catch(Exception e){e.printStackTrace();}		
		finally{
			dbClose();			
		}
		return cnt;	
	}
	
	//지역 간단 설명 가져오기
	public List<ListVO> getDesc(String dong, int i){
		ArrayList<ListVO> al = new ArrayList<ListVO>();
		
		try{
			String sql="";
			if(i==1){
				sql= "select hdname, subject, userid from listtbl where rownum<6 order by num desc";
				
			}else if(i==2){
				sql= "select hdname, subject, userid from listtbl where dong=? and rownum<6 order by num desc";
				
			}
			dbConn(sql);
			pstmt.setString(1, dong);
			rs= pstmt.executeQuery();
			
			while(rs.next()){
				ListVO cv = new ListVO();
				cv.setHdName(rs.getString(1));
				cv.setSubJect(rs.getString(2));
				cv.setUserId(rs.getString(3));
				
				al.add(cv);
			}
		}catch(Exception e){e.printStackTrace();}		
		finally{
			dbClose();			
		}
		return al;
	}
	
	//내 지역 설정하기
	public int setMalocal(String dong, String id){
		int res =0;
		String firstSet="";
		String sql="";
		String sql2="";
		String a="";
		
		try{
			sql2="select mylocal from membertbl where userid=?";
			dbConn(sql2);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				firstSet=rs.getString(1);
			}
			StringTokenizer st = new StringTokenizer(firstSet,"-");
			String[] tt = new String[st.countTokens()];
			int i=0;
			while(st.hasMoreTokens()){
				tt[i]=st.nextToken();
			}
			int ch=0;
			for(int c=0;c<st.countTokens();c++){
				if(tt[c]!=dong){
					ch=1;
				}
			}
			
			if(ch==1){
			
				
				sql="update membertbl set mylocal = mylocal||?  where userid=?"; 
					dbConn(sql);
				if(firstSet==null||firstSet==""){
					pstmt.setString(1, dong);				
				}else{
					pstmt.setString(1, "-"+dong);				
				}
					pstmt.setString(2, id);
	
					res =pstmt.executeUpdate();
			}else{
				res=3;
			}
		}catch(Exception e){e.printStackTrace();}		
		finally{
			dbClose();			
		}
		return res;

	}
	//내 지역 설정 나타내기
	public String getMalocal(String id){
		String firstSet="";
		try{
			String sql="select mylocal from membertbl where userid=?";
			dbConn(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				firstSet=rs.getString(1);
			}
			
		}catch(Exception e){e.printStackTrace();}		
		finally{
			dbClose();			
		}
		return firstSet;
	}
	
	//상세주소들 뿌려주기
	public List<ListVO> getPlaces(String dong){	
		ArrayList<ListVO> al = new ArrayList<ListVO>();
		try{
			String sql="select substr(location,2,length(location)-2), userid, subject, writedate from listtbl where dong=?";
			dbConn(sql);
			pstmt.setString(1, dong);
			
			rs=pstmt.executeQuery();
	
			while(rs.next()){
				ListVO  lv = new ListVO();
				lv.setPlace(rs.getString(1));
				lv.setUserId(rs.getString(2));
				lv.setSubJect(rs.getString(3));
				lv.setWriteDate(rs.getString(4));
				al.add(lv);
			}
		}catch(Exception e){e.printStackTrace();}		
		finally{
			dbClose();			
		}
		return al;
	}
	//총 레코드 개수
	public int recordCount(String dong, String searchKey, String searchWord){
		int cnt=0;
		try{
			String sql="";
			if(searchWord==null || searchWord.equals("")){
				sql="select count(num) from listTbl where dong=?";				
			}else{
				sql="select count(num) from listTbl where dong=? and "+searchKey+" like '%"+searchWord+"%'";
			}
			dbConn(sql);
			pstmt.setString(1, dong);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbClose();	
		}
		return cnt;
	}
	//총 이미지 레코드 개수
	public int imgrecordCount(String dong){
		int cnt=0;
		try{
			String sql="";
			sql="select count(file1) from listTbl where dong=?";				
			
			dbConn(sql);
			pstmt.setString(1, dong);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbClose();	
		}
		return cnt;
	}
	//해당 페이지 레코드 선택
		public List<ListVO> select(String dong, int pageNum, int recordSize, int totalPageSize, String searchKey, String searchWord){
			ArrayList<ListVO>  al = new ArrayList<ListVO>();
			int totalRecord = recordCount(dong, searchKey, searchWord);
			try{
				String sql;
				int cn = totalRecord % recordSize;//총레코드 수%한 페이지당 레코드 으로 나눈 나머지;
				sql="select * from (select * from (select num, hdname, subject, "
					+ "userid, to_char(writedate,'YYYY/MM/DD HH:MI') "
					+ "writedate from listtbl where dong=? ";
				
				if(searchWord !=null&&searchWord!=""){
					sql += "and "+searchKey+" like '%"+searchWord+"%' ";
				}
					 
					sql+="order by num desc) where "
						+ "rownum<=? order by num asc) where rownum<=? order by num desc";
			
				dbConn(sql);
				pstmt.setString(1, dong);
				pstmt.setInt(2, pageNum*recordSize);
				
				if(pageNum !=totalPageSize || cn==0){//마지막 페이지 아닐때
					pstmt.setInt(3, recordSize);
				}else{//마지막 페이지 일때
					pstmt.setInt(3, cn);		
				}
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					ListVO gv = new ListVO();
					gv.setNum(rs.getInt(1));
					gv.setHdName(rs.getString(2));
					gv.setSubJect(rs.getString(3));
					gv.setUserId(rs.getString(4));
					gv.setWriteDate(rs.getString(5));
					al.add(gv);
				}	
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				dbClose();	
			}
			return al;
		}
		
		
		
		//이미지 리스트 가져오기
		public List<ListVO> getImages(String dong, int pageNum, int recordSize, int totalPageSize){
			ArrayList<ListVO>  al = new ArrayList<ListVO>();
			int totalRecord = imgrecordCount(dong);
			String sql="";
			try{
				int cn = totalRecord % recordSize;//총레코드 수%한 페이지당 레코드 으로 나눈 나머지;
				sql="select * from ("
						+ "select * from ("
						+ "select num, file1, file2, file3 from listtbl where dong=? order by num desc)"
						+ " where rownum<=? order by num asc) where rownum<=? order by num desc";
				dbConn(sql);
				pstmt.setString(1, dong);
				pstmt.setInt(2, pageNum*recordSize);
				
				if(pageNum !=totalPageSize || cn==0){//마지막 페이지 아닐때
					pstmt.setInt(3, recordSize);
				}else{//마지막 페이지 일때
					pstmt.setInt(3, cn);		
				}
				rs = pstmt.executeQuery();
						
				while(rs.next()){
					ListVO lv = new ListVO();
					String[] filename =new String[3];
					lv.setNum(rs.getInt(1));
					for(int i=0; i<filename.length; i++){
						filename[i] = rs.getString(2+i);
						//if(filename[i]==null){filename[i]="";}
					}
					lv.setFilename(filename);
					al.add(lv);
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				dbClose();	
			}
			return al;
		}
		
		//게시판 읽기
		public ListVO getLiData(String id, int num){
			ListVO lv = new ListVO();
			try{
					String sql = "select hdname,subject,content,listpwd,writedate,location,dong,file1,file2,file3,num,userid from listTbl where num=?";
					dbConn(sql);
					//pstmt.setString(1, id);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					while(rs.next()){
						lv.setHdName(rs.getString(1));
						lv.setSubJect(rs.getString(2));
						lv.setContent(rs.getString(3));
						lv.setListPwd(rs.getString(4));
						lv.setWriteDate(rs.getString(5));
						lv.setLocation(rs.getString(6));
						String file[] = new String[3];
						lv.setDong(rs.getString(7));
						for(int i=0;i<file.length;i++){
							file[i]=rs.getString(7+i);
						}
						lv.setNum(rs.getInt("num"));
						lv.setUserId(rs.getString(12));
						lv.setFilename(file);						
												
					}
			
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				dbClose();
			}return lv;
		}
	
		//게시판 1개 이미지 가져오기
		public ListVO getImage(String dong, int num){
			ListVO lv = new ListVO();
			String sql="";
			try{
				
				sql="select file1, file2, file3 from listtbl where num=? and dong=?";
				dbConn(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, dong);
				
				rs = pstmt.executeQuery();
						
				while(rs.next()){
					String[] filename =new String[3];
					for(int i=0; i<filename.length; i++){
						filename[i] = rs.getString(1+i);
					}
					lv.setFilename(filename);
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				dbClose();	
			}
			return lv;
		}
		
		public int update(MemberVO mv){
			int cnt = 0;
			try{
				String sql = "update membertbl set userpwd=?, tel=?, "
						+ "zipcode=?, addr1=?, addr2=?, mylocal=?, email=?"
						+ " where userid=?";
				dbConn(sql);
				//pstmt.setString(1, toKorUTF(mv.getUserName()));
				pstmt.setString(1, mv.getUserPwd());
				pstmt.setString(2, mv.getTel1()+"-"+mv.getTel2()+"-"+mv.getTel3());
				pstmt.setString(3, mv.getZipCode());
				pstmt.setString(4, toKorUTF(mv.getAddr1()));
				pstmt.setString(5, toKorUTF(mv.getAddr2()));
				
				String m1="";
				if(mv.getMl1()!=null) m1 += mv.getMl1();
				if(mv.getMl2()!=null) m1 += "-"+mv.getMl2();
				if(mv.getMl3()!=null) m1 += "-"+mv.getMl3();
				
				pstmt.setString(6, toKorUTF(m1));
				
				pstmt.setString(7, mv.getEmail());

				pstmt.setString(8, mv.getUserId());
				
				cnt = pstmt.executeUpdate();
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				dbClose();
			}
			return cnt;
		}
		//(page.jsp) 쪽지쓰기
		public int pageSend(PageVO pv){
			int result = 0;
			try{
				String sql = "insert into pagetbl values(1, "
						+ "?, 1, ?, 1, ?, sysdate, pagesq.nextval)";
				dbConn(sql);
				
				pstmt.setString(1, pv.getUserId1());
				pstmt.setString(2, pv.getUserId2());
				pstmt.setString(3, toKorUTF(pv.getText()));
				
				result = pstmt.executeUpdate();
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				dbClose();
			}
			
			return result;
		}
		//(pageList.jsp) page lord 쪽지 보관함
		public List<PageVO> select(int pNum, int rSize, int tPage, String userId){
			ArrayList<PageVO> aList  = new ArrayList<PageVO>();
			PageVO pv = new PageVO();
			try{
				//int tr = recordCnt();
				String sql="";
					if(pNum != tPage){	
						sql = "select * from (select * from(select ";
						sql += "userid1, userid2, text,";
						sql += "to_char(writedate, 'YYYY/MM/DD HH:MI'),num";
						sql += " from pagetbl where userid1=? order by num desc)";
						sql += " where rownum<=? order by num asc)";
						sql += " where rownum<=? order by num desc";
						dbConn(sql);
						pstmt.setString(1, userId);
						pstmt.setInt(2, pNum*rSize);
						pstmt.setInt(3, rSize);
						rs = pstmt.executeQuery();
					}else{
						//int cn = tr % rSize;

						sql = "select * from (select * from(select ";
						sql += "userid1, userid2, text,";
						sql += "to_char(writedate, 'YYYY/MM/DD HH:MI'), num";
						sql += " from pagetbl where userid1=? order by num desc)";
						sql += " where rownum<=? order by num asc)";
						sql += " where rownum<=? order by num desc";
						dbConn(sql);
						pstmt.setString(1, userId);
						pstmt.setInt(2, pNum*rSize);
						pstmt.setInt(3, rSize);
						//pstmt.setInt(3,  cn);
						rs = pstmt.executeQuery();

					}
				
				
				while(rs.next()){
					PageVO gv = new PageVO();
					gv.setUserId1(rs.getString(1));
					gv.setUserId2(rs.getString(2));
					gv.setText(rs.getString(3));
					gv.setWriteDate(rs.getString(4));
					gv.setNum(rs.getInt(5));
					aList.add(gv);
					
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				try{
					dbClose();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			return aList;
			
		}
		//(pageList.jsp) page lord count 받는이Id정보 검색
		public int recordCnt(String userId){
			int cnt = 0;
			try{
				
				String sql = "select count(WriteDate) from pagetbl where userId1=?";
				dbConn(sql);
				pstmt.setString(1,  userId);
				rs = pstmt.executeQuery();
				rs.next();
				cnt = rs.getInt(1);
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				try{
					dbClose();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			return cnt;
		}
		//(pageList.jsp) page delete 쪽지 삭제
		public int deleteRecord(int num){
			int r=0;
			try{
				String sql = "delete from pagetbl where num=?";
				dbConn(sql);
				pstmt.setInt(1, num);
				
				r = pstmt.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				try{
					dbClose();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			return r;
		}
	
	//우편번호 검색
		public List<ZipVO> zipcodeSearch(ZipVO mv){
			List<ZipVO> lst = new ArrayList<ZipVO>();
			try{
				String sql = "select * from zipTbl where doro like '%"+mv.getAddr1()+"%'";
				dbConn(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					ZipVO mv2 = new ZipVO();
					mv2.setZipCode(rs.getString("zipcode"));
					String addr1 = rs.getString("sido")+rs.getString("gu");
					addr1+=" "+rs.getString("doro")+" ";
					
					String bName = rs.getString("bName");
					if(bName != null){addr1 += bName;}
					
					addr1 +="("+rs.getString("dong")+")";
					
					 
					mv2.setAddr1(addr1);
					mv2.setAddr2(rs.getInt("zibun1") +"~"+ rs.getInt("zibun2"));
					
					lst.add(mv2);
				}	
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				dbClose();
			}
			return lst;
		}	
		
		//(memberEdit.jsp) Member lord 회원정보 
		public MemberVO selectRecord(String userid){
			MemberVO mv = new MemberVO();
			try{
				String sql ="select username, userpwd, tel, "
						+ "zipcode, addr1, addr2, mylocal, email"
						+ " from membertbl where userid=?";
				dbConn(sql);
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userid);
				rs = pstmt.executeQuery();
				if(rs.next()){
					mv.setUserName(rs.getString(1));
					mv.setUserPwd(rs.getString(2));
					
					String tel = rs.getString(3);
					String telArr[] = tel.split("-");
					mv.setTel1(telArr[0]);
					mv.setTel2(telArr[1]);
					mv.setTel3(telArr[2]);
				
					mv.setZipCode(rs.getString(4));
					mv.setAddr1(rs.getString(5));
					mv.setAddr2(rs.getString(6));
					
					//mv.setMyLocal(rs.getString(7));
					String myLocal = rs.getString(7);
					String mlArr[] = new String[2];
					mlArr = myLocal.split("-");

					mv.setMl1(mlArr[0]);
					mv.setMl2(mlArr[1]);
					mv.setMl3(mlArr[2]);
					mv.setEmail(rs.getString(8));
					
					
				}
				
			}catch(Exception e){
					e.printStackTrace();
			}finally{
				try{
					dbClose();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			return mv;

		}
	/*
	public void ListWrite(){
		try{
			String sql ="";
			
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			try{
				dbClose();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return ;

	}
	
	public void ListRead(){
		try{
			String sql ="";
			
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			try{
				dbClose();
			}catch(Exception e){
				e.printStackTrace();
			}
		}

	}

	public void ListEdit(){
		try{
			String sql ="";
			
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			try{
				dbClose();
			}catch(Exception e){
				e.printStackTrace();
			}
		}

	}
	
	public void ListDelete(){
		try{
			String sql ="";
			
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			try{
				dbClose();
			}catch(Exception e){
				e.printStackTrace();
			}
		}

	}
	
	public void MapSave(){
		try{
			String sql ="";
			
		}catch(Exception e){
				e.printStackTrace();
		}finally{
			try{
				dbClose();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
*/


	
	
}
