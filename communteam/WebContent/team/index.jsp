<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	String idin = (String)session.getAttribute("userId");
	CommunDAO cdin = new CommunDAO();	
	String firstSet= cdin.getMalocal(idin);
	StringTokenizer stt; 
	String[] locals =new String[1];
	if(firstSet!=null&&firstSet!=""){
		stt = new StringTokenizer(firstSet,"-"); 
		locals=new String[stt.countTokens()];
		int localnum=0;
		while(stt.hasMoreTokens()){
			locals[localnum++]=stt.nextToken();			
		}		
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="css/commun.css" media="all"/>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script src="js/flux.js" type="text/javascript" charset="UTF-8"></script> <!--슬라이드용 JS파일 -->
<script>
	$(function(){
		//배경으로 사용되는 Slide SHOW
		window.mf = new flux.slider('#slide', {
			 autoplay: true,
			 pagination: false,
			 delay: 4000,
			 height:400,
			 transitions: ['slide']
		});
		//로그인시 내지역보기 기능
		$('#mylocal_af').on('mouseenter',function(){
			$("#mylocalShow").css("display","block");
		});
		
		$("#blackbar").on('mouseout', function(){
			$("#mylocalShow").css("display","none");
		}) 
		
		$("#mylocalShow").on({mouseover:function(){
			$("#mylocalShow").css("display","block");	
		}, mouseout:function(){
			$("#mylocalShow").css("display","none");
		}}) 
	});
	
	function goMylocal(dong){
		
		location.href="myCommun.jsp?id=<%=idin%>&dong="+dong;
	}
	
</script>

</head>
<!-- ------------------------------------------------------------------------------------ -->
<!-- ------------------------------------------------------------------------------------ -->	
<body id="indexBody">
<header id="headerbox">
	<div id="loginbox" style="z-index:3">
		<%@ include file="loginView.jspf" %>
		
	</div>
	<!-- ------------------------------------------------------------------------------------ -->	

	<h1 id="welcom">환영합니다!</h1>
	<div id="slide"> <!-- 배경화면 슬라이드에 사용되는 이미지가 들어간 박스 -->
		<img src="img/img1.jpg">
		<img src="img/img2.jpg">
		<img src="img/img3.jpg">
		<img src="img/img4.jpg">
		<img src="img/img5.jpg">
		<img src="img/img6.jpg">
	</div>

	<!-- ------------------------------------------------------------------------------------ -->	
	<div id="blackbar"> <!-- 검은색으로 보이는 Bar부분--></div>
	<div id="searchbox"><!-- 검색드롭 박스가 있는 창 -->
		<%@ include file="search.jsp" %>
	</div>
</header>
<!-- ------------------------------------------------------------------------------------ -->
<!-- 내지역정보가 로그인시 나타남------------------------------------------------------------------------------------ -->
		<% if(session.getAttribute("loginCheck")!=null && session.getAttribute("loginCheck").equals("Y")&&firstSet!=null&&firstSet!=""){
		%>
		 	<div id="mylocalShow">
				<ul>	
					<%
				
					for(int i=0;i<locals.length;i++){
						if(i<=2){
					%>
						<li id="mylocals" onClick="goMylocal('<%=locals[i]%>')"><%=locals[i]%></li>
					<%	
						}
					}
					%>
				</ul>
			</div> 
		 <% }%>

<!--대학교 사진들 15.09.04.12시 ------------------------------------------------------------------------------------ -->
<div id="indexcenter">
	<img src="img/indexcenter.jpg" alt="사이트설명:지역의 친구들과 식재료를 같이사거나, 같이 밥을먹고, 같이노는 행사를 만듭니다.">
</div>

<!-- 하단부의 회사의 정보가 들어간 부분--------------------------------------------------------------->
<footer id="indexFooter">
<pre>

㈜여행박사 │ 대표 : 황주영 │ 본사 : 서울시 용산구 한강대로 313 (갈월동 69-109) 부산지사 : 부산광역시 중구 대청로 148 
사업자등록번호 : 105-87-26271 │ 통신판매업신고번호 : 제2010 서울용산 00927호 │ 관광사업등록증번호 : 제2010-000006호 
대표전화 : 서울 070-7017-2100 부산 070-7012-7000 │ 팩스 : 02-6008-5717 │ 보증보험 : 15억원 가입 │ 
부득이한 사정에 의해 여행일정이 변경되는 경우 여행자의 사전 동의를 받습니다.
Copyright(c) TOURBAKSA.COM All Rights Reserved.</pre>
</footer>
</body>
</html>
