
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="team.CommunDAO"%>
    <%
    	String id=request.getParameter("id");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>
<style>
	.txt{font-weight:bold;color:red}
</style>
<script>
	function idSetting(id){
		opener.document.frm.userId.value=id;
		opener.document.frm.idChk.value="2";
		window.close();
	}
	function idInputCheck(){
		if(document.idFrm.id.value==null||document.idFrm.id.value==""){
			alert("중복검사할 아이디를 입력하세요");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<div>
<%
	if(!(id==null||id=="")){//아이디를 입력한 경우
		//db에 데이터 있는지 확인
		CommunDAO cd = new CommunDAO();
		boolean result = cd.idCheck(id);
		
		if(result){
			%>
			<span class="txt"><%=id %></span>는 사용 불가능한 아이디입니다.
			<%
		}else{
			%>
			<%=id %>는 사용가능한 아이디입니다.
			<input type="button" value="아이디 적용" onClick="idSetting('<%=id%>')"/>
			<%
		}
		%>
	<%}
%>
	
	<hr/>
	<h2>새로운 아이디 입력 후 중복검사</h2>
	<form method="post" action="idCheck.jsp" name="idFrm" onSubmit="return idInputCheck()">
		<label>아이디 입력</label>
		<input type="text" name="id"/>
		<input type="submit" value="아이디 중복검사"/>
		
	</form>
</div>
</body>
</html>