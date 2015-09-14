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
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.3.min.js"></script>
<script src="js/flux.js" type="text/javascript" charset="UTF-8"></script> <!--슬라이드용 JS파일 -->
<script>
	$(function(){
		
		window.mf = new flux.slider('#slide', {//배경으로 사용되는 Slide SHOW
			 autoplay: true,
			 pagination: false,
			 delay: 4000,
			 transitions: ['slide']
		});
		
		$('#mylocal_af').on('click',function(){
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
	/////////2015.09.04 12시 불필요 부분 삭제////////////////////////////
</script>
<style>
	#mylocalShow{display:none;cursor: pointer;width:175px;background-color:white;
				 text-align:center; position:relative;left:50%;margin-left:-450px;}
	#mylocalShow ul>li{width:175px;list-style-type:none;height:48px;
	line-height:50px;border:1px solid gray;float:none }
</style>
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
<!-- 내지역정보가 로그인시 나타남-15.09.04 12시----------------------------------------------------------------------------------- -->
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
<section id="indexSection">
	<ul id="indexUl">
		<li><div><a href="communFinding.jsp?gu=성북구&dong=안암동">고려대</a></div></li>
		<li><div><a href="communFinding.jsp?gu=관악구&dong=신림동">서울대</a></div></li>
		<li><div><a href="communFinding.jsp?gu=동작구&dong=흑석동">중앙대</a></div></li>
		<li><div><a href="communFinding.jsp?gu=성동구&dong=행당동">한양대</a></div></li>
		<li><div><a href="communFinding.jsp?gu=광진구&dong=화양동">건국대</a></div></li>
		<li><div><a href="communFinding.jsp?gu=동대문구&dong=이문동">한국외대</a></div></li>
	</ul>
</section>

<!-- 하단부의 회사의 정보가 들어간 부분--------------------------------------------------------------->
<footer id="indexFooter">
	<div id="company">
		<h3>FRESH SHARE FOOD CO. All Desige reserved by HERA.co</h3>
		<h5>Tel : 02 - 1234 - 5678 E-mail : help@fsfc.co.kr</h5>
	</div>
</footer>
</body>
</html>
