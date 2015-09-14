<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team.CommunDAO" %>
<%@ page import = "team.MemberVO" %>

<% if(session.getAttribute("loginCheck")!=null && session.getAttribute("loginCheck").equals("Y")) %>
<%
	CommunDAO cd = new CommunDAO();
	String userid = (String)session.getAttribute("userId");
	MemberVO cv = cd.selectRecord(userid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/memberEdit.js"></script>
<style>
	#pic img{width:700px;height:140px}
	#register{width:700px; height:600px; position:absolute; left:50%; margin-left:-350px;top:15%;
		border:1px solid gray}
	#navi{width:150px;height:400px;background-color:pink;
		text-align:right;position:absolute}
	#content{width:550px;height:400px;position:absolute;left:150px}
	#Btn{position:relative;left:330px;top:500px}
</style>
<script>
	function idCheckWin(){
		window.open("idCheck.jsp?id="+document.frm.userId.value,"idchkwin","width=400,height=200,scrollbars=no");
		
	}
	function zipWin(){
		window.open("zipSearch.jsp","zipWin","width=500, heigth=500")
	}

	function dongDel(n){
		document.getElementById("Ml"+n).value=" ";
		document.getElementById("mMl"+n).value=" ";

	}
</script>

</head>
<body>
<div id="register">
	<div id="pic">
		<img src="img/inforedit.jpg">
	</div>
	<div id="navi"><br/>
		<label>아이디</label><br/><br/>
		<label>비밀번호</label><br/><br/>
		<label>비밀번호 확인</label><br/><br/><br/>
		<label>이름</label><br/><br/>
		<label>이메일</label><br/><br/>
		<label>우편 번호</label><br/>
		<label>주소</label><br/><br/><br/>
		<label>전화번호</label><br/><br/>
		<label>내지역 보기</label><br/><br/>
		
	</div>
	<div id="content">
	<form method="post" action="memberEditOk.jsp" id="registerChk" name="frm">
		<br/><label style=color:red>＊　</label>
		<input type="text" name="userId" id="Id"readonly style="background-color: #e2e2e2;" value="<%=session.getAttribute("userId")%>"/>		
		<input type="hidden" value="1" name="idChk" id="idChk"/><br/><br/>
		<label style=color:red>＊　</label><input type="password" name="userPwd" id="pass" value="<%=cv.getUserPwd()%>"><br/>
		<label>　비밀번호는 4자리 이상 12자리 이하로 입력해주세요.</label><br/>
		<label style=color:red>＊　</label><input type="password" id="passCheck" name="userPwd2"><br/><br/>
		<label style=color:red>＊　</label><input type="text" id="name" name="userName" readonly style="background-color: #e2e2e2;" value="<%=cv.getUserName()%>"/><br/><br/>
		<label style=color:red>＊　</label><input type="text" id="email" name="email" value="<%=cv.getEmail()%>"><br/><br/>
		<label style=color:red>＊　</label><input type="text" id="zipCode" name="zipCode" maxlength="5" value="<%=cv.getZipCode()%>">
		<input type="button" value="검색" onClick="zipWin()"> <br/>
		<label style=color:red>＊　</label><input type="text" id="addr1" name="addr1" value="<%=cv.getAddr1()%>"><br/>
		<label>　　</label><input type="text" id="addr2" name="addr2" value="<%=cv.getAddr2()%>"><br/><br/>
		<label style=color:red>＊　</label>
		<select name="tel1">
			<option value="010"<%if(cv.getTel1().equals("010")){out.println("selected");} %>>010</option>
			<option value="011"<%if(cv.getTel1().equals("011")){out.println("selected");} %>>011</option> 
			<option value="000"<%if(cv.getTel1().equals("000")){out.println("selected");} %>>000</option>
		</select>
		-<input type="text" style="width:60px" id="tel2" name="tel2" maxlength="4" value="<%=cv.getTel2()%>">-<input type="text" style=width:60px id="tel3" name="tel3" maxlength="4" value="<%=cv.getTel3()%>"><br/>
		<label style=color:red>＊　</label><input type="text" name="mMl1" id="mMl1"readonly style="background-color: #e2e2e2;" value="<%=cv.getMl1()%>"/>
		<!-- ------- -->
		<input type="hidden" name="ml1" id="Ml1" style="background-color: #e2e2e2;" value="<%=cv.getMl1()%>"/>
		
		<input type="button" value="삭제" id="dd" onClick="dongDel(1)"/><br/>
		<label>　　</label><input type="text" id="mMl2" name="mMl2" readonly style="background-color: #e2e2e2;" value="<%=cv.getMl2()%>">
		<!-- ------- -->
		<input type="hidden" name="ml2" id="Ml2"style="background-color: #e2e2e2;" value="<%=cv.getMl2()%>"/>
		
		<input type="button" value="삭제"  onClick="dongDel(2)"/><br/>
		<label>　　</label><input type="text" id="mMl3" name="mMl3" readonly style="background-color: #e2e2e2;"value="<%=cv.getMl3()%>">
		<!-- ------- -->
		<input type="hidden" name="ml3" id="Ml3"style="background-color: #e2e2e2;" value="<%=cv.getMl3()%>"/>
		
		<input type="button" value="삭제"  onClick="dongDel(3)"/><br/><br/>
		</div>
	<div id="Btn">
		<input type="submit" value="등록">
		<input type="reset" value="취소">
	</div>
	</form>
	
</div>
</body>
</html>