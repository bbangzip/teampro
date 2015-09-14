<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/register.js"></script>
<style>
	body{background:url("img/blur-clould.jpg") no-repeat center center fixed;  background-size:cover; margin:0px; padding:0px;}
	
	#register{width:700px; height:542px; position:absolute; left:50%; margin-left:-350px;top:15%;
		border:1px solid gray}
	#pic img{width:700px;}
	#navi{width:150px;
		  height:400px;
		  text-align:right;
		  position:absolute;}
	#navi ul {list-style-type:none; margin-right:10px;}
	#navi li {height:50px;  margin:0px;}
	#content{width:550px;
			 height:400px;
			 position:absolute;
			 left:150px}
	#content ul{list-style-type:none;}
	#content li:nth-child(3) {font-size:9pt; height:25px;}
	#content li:nth-child(5) {font-size:9pt; height:25px;}
	#content li:nth-child(6) {height:50px;} /*비밀번호확인*/
	#content li:nth-child(7) {height:50px;} /*이름*/
	#content li:nth-child(8) {height:50px;} /*우편번호*/
	#content li:nth-child(10) {height:30px;} /*주소2*/
	#content li:nth-child(11) {height:45px;} /*전화번호*/
	
	
	#Btn{position:relative;left:250px;top:400px;}
	#Btn input {width:100px; height:30px;}
</style>
<script>
	function idCheckWin(){
		window.open("idCheck.jsp?id="+document.frm.userId.value,"idchkwin","width=400,height=200,scrollbars=no");
		
	}
	function zipWin(){
		window.open("zipSearch.jsp","zipWin","width=400, heigth=400")
	}
</script>
</head>
<body>
<div id="register"><!--전체를 감싸는 틀 -->

<div id="pic"><img src="img/registBanner.jpg"></div><!-- 상단부 배너이미지 -->



<form method="post" action="registerOk.jsp" id="registerChk" name="frm">

	<div id="navi">
		<ul>
			<li>아이디</li>
			<li>비밀번호</li>
			<li>비밀번호확인</li>
			<li>이름</li>
			<li>우편 번호</li>
			<li>주소</li>
			<li>전화번호</li>
			<li>이메일</li>
		</ul>
	</div>
	
	
	<div id="content">
		<ul id="content_ul">
<!-- 1 -->	<li><input type="hidden" value="1" name="idChk" id="idChk"/></li>
<!-- 2 -->	<li><input type="text" name="userId" id="Id" maxlength="12">		
				<input type="button" value="ID중복검사" name="userIdChk" id="userIdChk" onClick="idCheckWin()">
<!-- 3 -->	<li>아이디는 영문,숫자 조합으로 하셔야 합니다.[4자리 이상 12자리 이하]</li>
<!-- 4 -->	<li><input type="text" name="userPwd" id="pass"></li>
<!-- 5 -->	<li>비밀번호는 4자리 이상 12자리 이하로 입력해주세요.</li>
<!-- 6 -->	<li><input type="text" id="passCheck" name="userPwd2"></li>
<!-- 7 -->	<li><input type="text" id="name" name="userName"></li>
<!-- 8 -->	<li><input type="text" id="zipCode" name="zipCode" maxlength="5">
				<input type="button" value="검색" onClick="zipWin()"></li>
<!-- 9 -->	<li><input type="text" id="addr1" name="addr1" size="40"></li>
<!-- 10 -->	<li><input type="text" id="addr2" name="addr2"  size="40" ></li>
<!-- 11 -->	<li><select name="tel1"><option value="010">010</option></select>-<input type="text" style="width:60px" id="tel2" name="tel2" maxlength="4">-<input type="text" style=width:60px id="tel3" name="tel3" maxlength="4"></li>
<!-- 12 -->	<li><input type="text" id="email" name="email"></li>
		</ul>
	</div>
	
	<div id="Btn">
		<input type="submit" value="등록">
		<input type="reset" value="초기화">
		<input type="button" value="홈" onClick="location.href='index.jsp'">
	</div>



</form>
</div>
</body>
</html>