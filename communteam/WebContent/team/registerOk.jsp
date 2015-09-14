
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="team.CommunDAO"%>
    <jsp:useBean id="member" class="team.MemberVO" scope="page"/>
    <jsp:setProperty name="member" property="*"/>
 <%
 	CommunDAO cd = new CommunDAO();
 	int result  = cd.insertRecord(member);
 	if(result>0){
 		%>
 			<script>
 				alert("회원가입됨")
 				location.href="index.jsp"
 			</script>
 		<%
 	}else{
 		%>
 			<script>
 				alert("가입실패")
 				history.go(-1);
 			</script>
 		<%
 	}
 	
 %>
