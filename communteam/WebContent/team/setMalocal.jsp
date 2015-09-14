<%@page import="team.CommunDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CommunDAO cd =new CommunDAO();
	String id= request.getParameter("id");
	String gu= request.getParameter("gu");
	String dong =request.getParameter("dong");
	int cntLocal = cd.setMalocal(dong , id);
	
	if (cntLocal==1){%><script>alert("등록이 완료되었습니다.");</script><%}
	else if(cntLocal==0){%><script>alert("등록이 실패했습니다.");</script><%}
	else if(cntLocal==3){%><script>alert("이미 등록하셨습니다.");</script><%}
	
%>
<script>
	location.href="communFinding.jsp?id=<%=id%>&dong=<%=dong%>&gu=<%=gu%>";
</script>