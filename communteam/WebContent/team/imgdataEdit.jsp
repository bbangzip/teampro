<%@page import="team.CdataDAO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="team.CommunDAO" %>
<jsp:useBean id="dataBean" class="team.ListVO" scope="page"/>
<% 
	String path = request.getServletContext().getRealPath("/team/imgfiles");//경로를 갖고옴
	//<img src=request.getContextPath()+"/css파일명/"+이미지명/>
	//D:\workspaceWebJSP\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPProejct(model1)  경로
	
	//폼의 데이터를 request 하고 서버에 파일 업로드를 함.
	//MultipartRequest( 객체종류, 파일경로, 업로드 될 파일의 최대크기, 한글코드, 중복파일처리객체 );
	int maxSize = 1024*1024*1024;//업로드 될 파일의 최대크기
	DefaultFileRenamePolicy pol = new DefaultFileRenamePolicy();//중복파일명의 rename실행 클래스
	//DefaultFileRenamePolicy 같은 이름의 파일을 업로드하면 이름을 바꿔줌(뒤에 1붙임)
	MultipartRequest mr = new MultipartRequest(request, path, maxSize, "UTF-8", pol);//
	
	//multipartRequest에서 데이터 얻어오기 -> dataBean에 담아서 java에서 적용
	dataBean.setNum(Integer.parseInt(mr.getParameter("num")));
	dataBean.setHdName(mr.getParameter("hdName"));
	dataBean.setUserId(mr.getParameter("userId"));
	dataBean.setSubJect(mr.getParameter("subJect"));
	dataBean.setContent(mr.getParameter("content"));
	dataBean.setListPwd(mr.getParameter("listPwd"));
	dataBean.setLocation(mr.getParameter("location"));
	dataBean.setDong(mr.getParameter("dong"));
	dataBean.setGu(mr.getParameter("gu"));
	
	
	
	//파일명 얻어오기
	Enumeration fileNames = mr.getFileNames();//업로드된 파일명을 구함
	String upFile[] = new String[3];
	int i=0;
	String upLoadFileName[]= new String[3];
	while(fileNames.hasMoreElements()){
		String filename = (String)fileNames.nextElement();
		String file = mr.getFilesystemName(filename);
		upFile[i++] = file;
	}
	dataBean.setFilename(upFile);//업로드된 파일명을 Bean에 셋팅	
	
	//hidden파일에 대한 처리
		String hiddenFile[] = new String[3]; //업로드 된지 확인하기 위해
		int z = 0;//업로드 되지 않은 경우 0, 업로드 된 경우 1
		for(int k=1; k<=3; k++){
			String f = "filename"+k;
			int status=0;
			for(int dd=0; dd<upLoadFileName.length;dd++){//이름이 있는 지 비교
				if(f.equals(upLoadFileName[dd])){
					status=1;
					break;
				}
			}
			//업로드 안되면 0
			if(status==0){hiddenFile[z++] = mr.getParameter(f);}
		}
		dataBean.setHiddenFile(hiddenFile);
	
		
	//레코드 추가
	CdataDAO dd = new CdataDAO();
	int result = dd.dataUpdate(dataBean,path,mr.getParameter("listPwd"));
	if(result==1){//레코드가 추가됨
		%>
		<script>
			alert("업로드가 완료되었습니다.");
			location.href="myCommun.jsp?gu=<%=dataBean.getGu()%>&dong=<%=dataBean.getDong()%>&id=<%=dataBean.getUserId()%>";
		</script>	
		<%
	}else if(result==2){
		%>
			<script>
				alert("비밀번호가 다릅니다");	
				history.go(-1);
			</script>
		<%
	}else{//레코드 추가 실패
		for(int idx=0; idx<upFile.length; idx++){
			if(upFile[idx] != null){
				File f = new File(path+upFile[idx]);//파일을 삭제하기 위한 File객체생성(위치path + 파일명upFile)
				//파일을 삭제하기 위한 File객체생성
				f.delete();//파일삭제
			}
		}	
	%>
		<script>
			alert("파일업로드를 실패하였습니다.");
			history.go(-1);
		</script>
	<%
	}
%>