<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="team.CommunDAO"%>
    <jsp:useBean id="member" class="team.PageVO" scope="page"/>
    <jsp:setProperty name="member" property="*"/>
 <%
 	CommunDAO cd = new CommunDAO();
 	int result  = cd.pageSend(member);
 	if(result>0){
 		%>
 			<script>
 				alert("쪽지를 보냈습니다.")
 				location.href="pageList.jsp"
 			</script>
 		<%
 	}else{
 		%>
 			<script>
 				alert("쪽지를 보내지 못했습니다.")
 				history.go(-1);
 			</script>
 		<%
 	}
 	
 %>
