<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team.CommunDAO" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	CommunDAO gd = new CommunDAO();
	int result = gd.deleteRecord(num);
	out.println(gd.deleteRecord(num));
	if(result>0){
		%>
		<script>
			alert("삭제되었습니다.");
			location.href="pageList.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("삭제 실패하였습니다.");
			history.go(-1);
		</script>
		<%
	}
%>