<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="team.CommunDAO" %>
<jsp:useBean id="memLogin" class="team.MemberVO" scope="page"></jsp:useBean>
<jsp:setProperty name="memLogin" property="userId"></jsp:setProperty>
<jsp:setProperty name ="memLogin" property="userPwd"></jsp:setProperty>

<%
	CommunDAO cd = new CommunDAO();
	cd.loginCheck(memLogin);
	if(memLogin.getLoginCheck().equals("Y")){
		session.setAttribute("userId", memLogin.getUserId());
		session.setAttribute("userName", memLogin.getUserName());
		session.setAttribute("loginCheck", memLogin.getLoginCheck());
		
		%>
			<script>
				alert("login 성공");
				location.href="index.jsp";
			</script>
		<%
	}else{
		%>
			<script>
				alert("login 실패");
				history.go(-1);
			</script>
		<%
	}
%>
    