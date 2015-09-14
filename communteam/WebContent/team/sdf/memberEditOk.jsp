<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team.CommunDAO" %>
<jsp:useBean id="memEdit" class="team.MemberVO" scope="page"></jsp:useBean>
<jsp:setProperty name="memEdit" property="*"></jsp:setProperty>



<%
	out.println(memEdit.getMl1()+"**"+memEdit.getMl2()+"**"+memEdit.getMl3()+"**"+memEdit.getEmail());
	CommunDAO md = new CommunDAO();
	int cnt = md.update(memEdit);

%>



<%
	if(cnt>0){
%>
		<script>
			alert("수정됨");
			location.href="../index.jsp";
		</script>
<%		
		
		
	}else{
%>
		<script>
			alert("수정 실패");
			history.back();
		</script>

<%		
	}

%>
