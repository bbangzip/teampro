package team;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import com.polytech.utility.Encoding;

public class CdataDAO extends Encoding {
	Context envCtx;
	DataSource ds;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void dbClose(){
		try{
			if(rs!=null){rs.close();}
			if(pstmt!=null){pstmt.close();}
			if(con!=null){con.close();}			
		}catch(Exception e){e.printStackTrace();}
	}
	
	public CdataDAO(){
		try{
			Context ctx = new InitialContext();
			envCtx = (Context)ctx.lookup("java:/comp/env");
			ds = (DataSource)envCtx.lookup("jdbc/myoracle");
		}catch(Exception e){}
	}
	//������ �ֱ�
	
	public int dataInsert(ListVO dataBean){
		int result = 0;
		try{
			String sql = "insert into listtbl values(listSq.nextVal, ?, ?, ?, ?, ?, sysdate, ?, ?, ?, ?, ?)";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dataBean.getHdName());
			pstmt.setString(2, dataBean.getSubJect());
			pstmt.setString(3, dataBean.getContent());
			pstmt.setString(4, dataBean.getUserId());
			pstmt.setString(5, dataBean.getListPwd());
			pstmt.setString(6, dataBean.getLocation());
			
			int inx = 3;
			String fileNames[] = dataBean.getFilename();
			
			for(int i=0; i<fileNames.length; i++){//0~4����
				if(fileNames[i]!=null){//null�� �ƴѰ��� ã�� -> ������ �ִ� ���� ã�Ƽ� inx�� ����.
					inx=i; break;
				}
			}
			int p=2;
			if(inx<=p){pstmt.setString(7, fileNames[p--]);}else{pstmt.setString(7, "");}
			if(inx<=p){pstmt.setString(8, fileNames[p--]);}else{pstmt.setString(8, "");}
			if(inx<=p){pstmt.setString(9, fileNames[p--]);}else{pstmt.setString(9, "");}						
			pstmt.setString(10, dataBean.getDong());
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbClose();
		}
		return result;
	}
	
	//�ڷ�� ����
	public int dataUpdate(ListVO dataBean, String path,String pwd){
		int result=0;
		String rightPwd="";
		try{
			String sql2="select listpwd from listtbl where num=?";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql2);
			pstmt.setInt(1, dataBean.getNum());
			rs=pstmt.executeQuery();
		
			if(rs.next()){
				rightPwd=rs.getString(1);
			}
			System.out.println(pwd);
			if(rightPwd.equals(pwd)){
				
				String sql="select file1, file2, file3 from listtbl where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, dataBean.getNum());
				rs = pstmt.executeQuery();
				String hiddenFile[]=dataBean.getHiddenFile();
				int p=0;
				if(rs.next()){
					//���� ������ ������ ���ϸ��� ã�� ���� ���� 
					for(int z=1;z<=3;z++){					
						String f = rs.getString(z);
						int status=0;//0�� ��񿡴� �ִµ� ���� ���Ͽ��� ����
						for(int k=0;k<hiddenFile.length;k++ ){
							if(hiddenFile[k]!=null){p=k;}
							if(f!=null && f.equals(hiddenFile[k])){
								status = 1;
								break;
							}
						}
						if(f!=null && status==0){
							//���ϻ���
							File delFile = new File(path+"/"+f);
							delFile.delete();
						}
					}
				}
				//���ϸ� ����
				String filename[]= dataBean.getFilename();
				if(p==0)p=-1;
				for(int i=filename.length-1;i>=0; i--){
					if(filename[i]!=null){
						hiddenFile[++p] = filename[i];
						
						
					}
				}
				//������Ʈ
				String sql3 = "update listtbl set hdName=?, subject=?, content=?, listpwd=?, file1=?, file2=?, file3=?,location=? where num=?";
				pstmt = con.prepareStatement(sql3);
				pstmt.setString(1, dataBean.getHdName());
				pstmt.setString(2, dataBean.getSubJect());
				pstmt.setString(3, dataBean.getContent());
				pstmt.setString(4, dataBean.getListPwd());
				for(int j=0; j<hiddenFile.length;j++){
					pstmt.setString(j+5, hiddenFile[j]);
				}
				pstmt.setString(8, dataBean.getLocation());
				pstmt.setInt(9, dataBean.getNum());
				result = pstmt.executeUpdate();
				
				//filename ���� ���ε� �� ���ϸ�(upFile)
				//hiddenFile �������� ���� ����
				
			}else{
				result=2;
			}
			
			
		}catch(Exception e){e.printStackTrace();}
		finally{
			dbClose();
		}
		return result;
	}
	
	//���ڵ� ����
	public void select(ListVO dv){
		try{
			String sql= "select * from listtbl where num=?";
			con = ds.getConnection();
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, dv.getNum());
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				dv.setHdName(rs.getString(2));
				dv.setSubJect(rs.getString(3));
				dv.setContent(rs.getString(4));
				dv.setListPwd(rs.getString(6));
				dv.setWriteDate(rs.getString(7));
				dv.setLocation(rs.getString(8));
				String file[] = new String[3];
				for(int i = 0; i<file.length;i++){
					file[i]=rs.getString(9+i);
				}
				dv.setFilename(file);
				dv.setDong(rs.getString(12));
			}
			
		}catch(Exception e){e.printStackTrace();}
		finally{
			dbClose();
		}
	}

}
