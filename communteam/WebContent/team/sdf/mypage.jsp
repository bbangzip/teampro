<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Commun 마이페이지</title>
<style>
h1{position: absolute;}
#mylist, #subMenu,#subMenu2{position:absolute; }
#mylist li{list-style-type:none; float:left;
			padding:15px; margin-right:55px; background-color:red}
#mylist{left:300px; top:20px;}

#subMenu li,#subMenu2 li{list-style-type:none; float:left;
			padding:15px; margin-right:2px; background-color:red}
#subMenu{left:300px; top:70px; display:none}
#subMenu2{left:473px; top:70px; display:none}
</style>
</head>
<body>
<div>
<h1>마이페이지</h1>
	<ul id="mylist">
		<a href="#"><li><span >내 정보 관리</span></li></a>		
		<a href="#"><li>비밀번호 변경</li></a>
		<a href="#"><li>회원 탈퇴</li></a>
	</ul>
	<!-- ----------subMenu---------- -->
	<ul id="subMenu">
		<a href="#"><li>쪽지 보관함</li></a>
		<a href="#"><li>게시글 보관함</li></a>
		<a href="memberEdit.jsp"><li>내 정보 수정</li></a>
	</ul>
	<ul id="subMenu2">
		<a href="#"><li>계정 비밀번호</li></a>
		<a href="#"><li>게시글 비밀번호</li></a>
	</ul>
	<!-- ------------------------------ -->
</div>
<hr>
<br><br><br><br>
<div>
</div>
</body>
</html>