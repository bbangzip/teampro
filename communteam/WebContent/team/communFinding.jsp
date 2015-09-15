<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ page import ="team.CommunDAO" %>
<%@ page import ="team.ZipVO" %>
<%@ page import ="team.ListVO" %>

<%@page import="java.util.ArrayList"%>
    <jsp:useBean id="member" class="team.ListVO" scope="page"/>
    <jsp:setProperty name="member" property="*"/>
<%
	request.setCharacterEncoding("UTF-8");
	CommunDAO cd = new CommunDAO();
	String gu  = request.getParameter("gu");
	String dong = (String)request.getParameter("dong");
	String userId=(String)session.getAttribute("userId");
	int cnt = cd.getLocal(dong);
	
	List<ListVO> lst = cd.getDesc(dong, 2);
	
	///////검색창
	List<ZipVO> dataList = new ArrayList<ZipVO>();
	cd.zipSearch(dataList);
	List<ZipVO> dataList2 = new ArrayList<ZipVO>();
	cd.zipSearch2(dataList2, gu);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery.gmap.js"></script>
<link href='https://fonts.googleapis.com/css?family=Sigmar+One' rel='stylesheet' type='text/css'>
<style>
	body{padding:0px;margin:0px}
	ul, li{margin:0px; padding:0px; list-style-type:none; float:left}
	a:link {text-decoration: none;}
    a:hover {text-decoration: none; }
	a:visted {text-decoration: none;}
	
	#main{width:1000px; height:1000px;margin-left:50%;
	left:-500px;position:absolute;}
	
	#map{width:100%;height:400px;top:100px;position:absolute;}
	#goomap{width:96%;height:90%;margin:2% 2% 2% 2%}
	#localFind{width:100%;height:100px;top:500px;text-align:center;line-height:100px;position:absolute;}
	/**************************************************************************************/
	#searchbox{width:100%; background-color:#67A2D5;
	position:absolute;}
		#scbox_main{width:800px; height:50px; background-color:white; position:relative; left:100px; top:30px }
		#scbox_main>div{float:left; margin:0px; padding:0px;width:158px; height:50px; font-weight:bold;  text-align: center; line-height:50px; border:1px solid gray;position:relative}
		#guShow{width:158px; height:50px;}	
		#dongShow{width:158px; height:50px;}	
			
			
			#searchBtn{background-color: #8BD6A0; width:130px; height:50px; color:white;}
			#searchBtn:hover{background-color:white; color:#8BD6A0; font-weight:bold}	
	/**************************************************************************************/
	#smallDesc{width:100%;height:400px;top:600px;text-align:right; position:absolute;  
	background-color:#D3E1EB;
	
	
	} /*commun*/
	#descript{margin:50px 0px 0px 50px;} 
	.descstyle{background-color: #CDD6DB;/*지역회원*/
	width:200px;border-top:1px solid black;border-bottom:1px solid black;border-left:1px solid black;text-align:center}
	.listStyle{background-color:white;width:200px;
	border-bottom:1px solid gray;border-left:1px solid gray;text-align:center}
</style>
<script>

	$(function(){
		//지도 표시
		<%if(dong!=null&&dong!="")%>{
		$('#goomap').gMap({
			address:"<%=dong%>",
			maptype:'ROADMAP',//종류= ROADMAP,HYBRID,SATELLITE,TERRAIN
			zoom: 16,
			markers:[{
				address:"<%=dong%>",
				html:"_address"
			}],
			controls:{
				panControl: false,
				zoomControl: true,
				mapTypeControl: true,
				scaleControl: true,
				streetViewControl: true,
				overViewMapControl: true
			}
		});
		}
		$("#guShow").on('change',function(){
		 	location.href="communFinding.jsp?gu="+$('#guShow').val()+"&dong="+$('#dongShow').val()});
		$("#dongShow").on('change',function(){

		 	location.href="communFinding.jsp?dong="+$('#dongShow').val()+"&gu="+$('#guShow').val()});
		
		
		
	});
	function myCommunMove(){
		<%
		if(session.getAttribute("loginCheck")!=null && session.getAttribute("loginCheck").equals("Y")){
		%>
			location.href="myCommun.jsp?dong=<%=dong%>&gu=<%=gu%>&id=<%=userId%>";		
		<%
		}else if(session.getAttribute("loginCheck")==null || session.getAttribute("loginCheck").equals("N")){
		%>
			location.href="login.jsp";
		<%}%>
		
	}
	function myCommunSet(){
		<%
		if(session.getAttribute("loginCheck")!=null && session.getAttribute("loginCheck").equals("Y")){
		%>	
			location.href='setMalocal.jsp?dong=<%=dong%>&id=<%=userId%>&gu=<%=gu%>';			
		<%
		}else if(session.getAttribute("loginCheck")==null || session.getAttribute("loginCheck").equals("N")){
		%>	location.href="login.jsp";
		<%}%>
	}
	function readBoardGo(){
		<%
		if(session.getAttribute("loginCheck")!=null && session.getAttribute("loginCheck").equals("Y")){
		%>
			location.href='readboard.jsp?subject=<%=member.getSubJect()%>&id=<%=member.getUserId()%>';			
		<%
		}else if(session.getAttribute("loginCheck")==null || session.getAttribute("loginCheck").equals("N")){
		%>
			location.href="login.jsp";
		<%}%>
	}
	function getAddr(){
		
		var addr = document.getElementById("guShow").value;
		var gu = document.getElementById("dongShow").value;
		
		location.href="communFinding.jsp?gu="+addr+"&dong="+gu;
	}
	
	
	
	
</script>
</head>
<body>
<%@ include file="pageLock.jspf" %>
<div id="main">
 
 	<%@ include file="header.jsp" %>
 
	<div id="map">
		<div id="goomap">
		</div>
	</div>
	<div id="localFind">
		<div id="searchbox">
		</div> <!-- 검은색으로 보이는 Bar부분 -->	
		<div id="scbox_main"> <!-- 실제 검색어창이 있는 부분 -->
			<div>지역찾기</div>
			<div>서울시</div>
			<div id="local1">
				<form method="get" action="communFinding.jsp">
				 <select id="guShow" name="guShow" size="1">
				 	<%for(int i=0; i<dataList.size(); i++){
				 		ZipVO zv = new ZipVO();
				 		zv = dataList.get(i);
							if(zv.getGu()!=null){%>
								<option value="<%=zv.getGu()%>" <%if(gu.equals(zv.getGu())){out.println("selected");} %>><%=zv.getGu()%></option>
						<%	}
				 	} %>
				 </select>
				 </form>
			</div>
			<div>
				 <select id="dongShow" name="dongShow" size="1">
					<%for(int a=0; a<dataList2.size(); a++){
						ZipVO zv = new ZipVO();
						zv = dataList2.get(a);
						if(dong!=null&&dong!=""){
						%>
							<option value="<%=zv.getDong() %>" <%if(dong.equals(zv.getDong())){out.println("selected");} %>><%=zv.getDong() %></option>
						<%}else{%>
							<option value="<%=zv.getDong() %>" <%if(a==0){out.println("selected");} %>><%=zv.getDong() %></option>
						<%}
					} %>		 
				</select>
			</div>
			<div id="searchBtn" onClick="getAddr()">찾기</div>
		</div>	
	</div>
	<div id="smallDesc">
		<div id="communlab" style="text-align:center"><label style="font-size:30px; font-family: 'Sigmar One', cursive; color:#67A2D5"><%=dong %></label></div>
		<input type="button" style="width:150px;height:40px" value="내 코뮨 설정" onClick="myCommunSet()"/>
		<input type="button" style="width:150px;height:40px" value="게시판 들어가기" onClick="myCommunMove()"/>
		<div id="descript">
			<ul>
				<li><label>지역회원:<%=cnt%>명</label></li></br>
				<li class="descstyle">머리글</li>
				<li class="descstyle" style="width:500px">최신글</li>
				<li class="descstyle" style="border-right:1px solid black;">작성자</li></br>
				<div id="listShow">
				<%for(int i=0;i<lst.size();i++){ 
					member = lst.get(i);
				%>
				<div>
					<li class="listStyle"><%=member.getHdName()%></li>
					<li class="listStyle" style="width:500px;"><%=member.getSubJect()%></li>
					<li class="listStyle" style="border-right:1px solid gray;"><%=member.getUserId()%></li>
				</div>
				<%} %>
				</div>
			</ul>		
		</div>
	</div>
</div>
</body>
</html>