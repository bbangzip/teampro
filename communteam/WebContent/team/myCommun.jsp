<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.List"%>
<%@page import="team.ListVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="team.CommunDAO"%>
<%@ page session="true" %>

<jsp:useBean id="member" class="team.MemberVO" scope="page"/>
<jsp:setProperty name="member" property="*"/>
<%

	request.setCharacterEncoding("UTF-8");
	String gu = request.getParameter("gu");
	String dong = request.getParameter("dong");
	String id=(String)session.getAttribute("userId");
	
	CommunDAO cd = new CommunDAO();
	//member = cd.getMalocal(id);
	String place;
	String[] places;
	String userIds;	
	String subjects;
	String writedates;
	int listNum;
	ListVO lv = new ListVO();
	List<ListVO> al = cd.getPlaces(dong);
	
	
	//페이징
	int pageNum =1;//현재 페이지 수
	int recordSize=15;//한페이지당 출력할 레코드 수 
	int totalPageSize= 1;//총페이지 수--총 레코드 수에 영향받음
	int onePageCnt=5;//한페이지당 보여줄 페이지수
	int startPage=1;//출력할 페이지 번호의 시작번호
	int totalRecord = 0;
	//이미지 페이지
	int imgpageNum =1;//현재 페이지 수
	int imgrecordSize=6;//한페이지당 출력할 레코드 수 
	int imgtotalPageSize= 1;//총페이지 수--총 레코드 수에 영향받음
	int imgonePageCnt=5;//한페이지당 보여줄 페이지수
	int imgstartPage=1;//출력할 페이지 번호의 시작번호
	int imgtotalRecord = 0;
	//현재 페이지
	String requestPageNum = request.getParameter("num");
	if(requestPageNum==null){//페이지 정보가 없을때
		pageNum=1;
	}else{//페이지 정보 있을때
		pageNum=Integer.parseInt(requestPageNum);
	}
	///////검색어 처리
	
	String searchWord=request.getParameter("searchWord");
	String searchKey = "";
	if(searchWord==null||searchWord==""){
		//searchKey = "";
		searchWord = "";
	}else{
		searchKey = request.getParameter("searchKey");
	}
	
	//총 페이지 수
	totalRecord = cd.recordCount(dong, searchKey, searchWord);//총 레코드 수 
	if(totalRecord%recordSize == 0){
		totalPageSize=totalRecord/recordSize;
	}else{
		totalPageSize=totalRecord/recordSize+1;
	}
	
	//시작 페이지 번호
	if(pageNum%onePageCnt==0){
		startPage = ((pageNum/onePageCnt)-1)*onePageCnt+1;
	}else{
		startPage = (pageNum/onePageCnt)*onePageCnt+1;
	}
	
	//////////////////이미지
	//이미지현재 페이지
	String imgrequestPageNum = request.getParameter("imgnum");
	if(imgrequestPageNum==null){//페이지 정보가 없을때
		imgpageNum=1;
	}else{//페이지 정보 있을때
		imgpageNum=Integer.parseInt(imgrequestPageNum);
	}
	
	//총 페이지 수
	imgtotalRecord = cd.imgrecordCount(dong);//총 레코드 수 
	if(imgtotalRecord%imgrecordSize == 0){
		imgtotalPageSize=imgtotalRecord/imgrecordSize;
	}else{
		imgtotalPageSize=imgtotalRecord/imgrecordSize+1;
	}
	
	//시작 페이지 번호
	if(imgpageNum%imgonePageCnt==0){
		imgstartPage = ((imgpageNum/imgonePageCnt)-1)*imgonePageCnt+1;
	}else{
		imgstartPage = (imgpageNum/imgonePageCnt)*imgonePageCnt+1;
	}

	List<ListVO> lst = cd.select(dong, pageNum, recordSize, totalPageSize, searchKey, searchWord);
	List<ListVO> imgfiles = cd.getImages(dong, imgpageNum, imgrecordSize, imgtotalPageSize); 
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
	a:link{color:black}
	a:hover{color:skyblue}
	a:active{color:black}
	a:visited{color:black}
	body{padding:0px;margin:0px}
	ul li{padding:0px;margin:0px;list-style-type:none;float:left}
	#main{width:1000px; height:1200px;background-color:#D3E1EB;margin-left:50%;
	left:-500px;position:absolute}
	#Banner{width:100%;height:100px;background-color:#67A2D5;position:absolute}
	#Banner>h1{font-size:40px;text-align:center;line-height:100px;font-family: 'Sigmar One', cursive; color:white;}
	#Banner>h1:hover{text-decoration: none; color:red}
	#Banner>h1:visited{text-decoration: none; color:white}
	a:link {text-decoration: none; } 
    a:hover {text-decoration: none;}
	a:visted {text-decoration: none;}
	
	#inform{position:absolute;width:200px;height:100px;top:0px;left:850px;}
	#map{width:100%;height:500px;top:100px;position:absolute}
	#goomap{width:96%;height:90%;margin:2% 2% 2% 2%}
	#board{width:100%;height:1200px;top:600px;position:absolute}
	#literBoard{width:950px;height:500px;margin:0% 2% 0% 2%}
	
	#literBoard input{position:absolute;top:450px;left:450px;}
	#imgBoard{width:1000px;height:500px;margin:0px;background-color:#D3E1EB ;position:absolute;top:600px}
	#imgShow li{width:200px;height:140px;list-style-type:none;float:left;
		border:1px solid gray;margin:10px 45px 10px 45px;}

	.descstyle{background-color:#88a3b9;width:150px;border-bottom:1px solid black;
	border-top:1px solid black;border-left:1px solid black;text-align:center;color:white}
	.listStyle{background-color:white;width:150px;
	border-bottom:1px solid gray;border-left:1px solid gray;text-align:center;float:left}

	.class{}
	#navi1{width:950px;height:100px;position:absolute;text-align:center}
	#navi2{position:absolute;width:100%;height:100px;text-align:center;bottom:0px}
	#pageList{background-color:white}
	#navi1>ul{position:relative;left:350px;height:20px;}
	#navi1>ul>li{width:40px}
	#navi2>ul{position:relative;left:350px}
	#navi2>ul>li{width:40px}
</style>
<script>
	$(function(){
		
		//지도 표시
		$('#goomap').gMap({
			address:"<%=dong %>",
			maptype:'ROADMAP',//종류= ROADMAP,HYBRID,SATELLITE,TERRAIN
			zoom: 19
			,
			markers:[
			<%
			for(int i=0; i<al.size();i++)
			{
				lv =al.get(i);
				place = lv.getPlace();
				userIds = lv.getUserId();
				subjects = lv.getSubJect();
				writedates = lv.getWriteDate();
				listNum=lv.getNum();
				places=place.split(",");
			
				if(i==0 ){		
					out.println("{");
				}else{
					out.println(",{");
				}
					out.println("latitude:"+places[0]+",");
					out.println("longitude:"+places[1]+",");
			
					out.println("html:\"번호:"+listNum+"작성자:"+userIds+"</br>제목:"+subjects+"</br><a href=\'readboard.jsp?num="+listNum+"&dong="+dong+"&gu="+gu+"\'>게시판으로 갑시다</a>\"");
					out.println("}");
			}
			%>
			],
			controls:{
				panControl: false,
				zoomControl: true,
				mapTypeControl: true,
				scaleControl: true,
				streetViewControl: true,
				overViewMapControl: true
			}
		});

		$("#malocal").on({mouseover:function(){
			$("#malocalShow").css("display","block")
		}, mouseout:function(){
			$("#malocalShow").css("display","none")
			
		}})
		
		$(".class").on({mouseenter:function(){
			$(this).children().css("background-color","#f0f3ff");	
		}, mouseleave:function(){
			$(this).children().css("background-color","white");
		}})
		
		
	});
	function searchWord(num){
		document.getElementById("num").value=num;
		document.search.submit();
	}
	function imgsearchWord(num){
		document.getElementById("imgnum").value=num;
		document.search.submit();
	}
	
	function readBoardGo(BoardNumber,writer){
		location.href="readboard.jsp?dong=<%=dong%>&gu=<%=gu%>&num=+"BoardNumber;
	}

</script>
</head>
<body>
<%@ include file="pageLock.jspf" %>
<div id="main">
	<div id="Banner">
		<h1><a href="index.jsp">COMMUN</a></h1>
		<div id="inform">
		 
		</div>
	</div>
	<div id="map">
		<label>　　　<%=dong%></label><br/>
		<div id="goomap">
		</div>
	</div>
	<div id="board">
		<div id="literBoard">
			<label>게시글</label><br/>
			<ul id="boardMain">
				<li class="descstyle">머리글</li>
				<li class="descstyle" style="width:400px">제목</li>
				<li class="descstyle">작성자</li>
				<li class="descstyle" style="border-right:1px solid gray">시간</li>
				<%for(int i=0;i<lst.size();i++){
					lv = lst.get(i);
					int number = lv.getNum();
				%>
				<li class="class">
					<div class="listStyle"><%=lv.getHdName()%></div>
					<div class="listStyle" style="width:400px"><a href="javascript:readBoardGo(<%=number%>,<%=lv.getUserId()%>)"><%=lv.getSubJect()%></a></div>
					<div class="listStyle"><%=lv.getUserId()%></div>
					<div class="listStyle" style="border-right:1px solid gray"><%=lv.getWriteDate()%></div>
				</li><br/>
				<%} %>
			</ul><br/>
			
			<input type="button" value="글쓰기" onClick="location.href='writeboard.jsp?dong=<%=dong%>&gu=<%=gu%>&id=<%=id%>'">
		</div>
		<div id="navi1">
			<ul>
				<% if(startPage>1){%>
					<li title="이전5페이지"><a href="javascript:searchWord(<%=startPage-onePageCnt %>)">◀◀</a></li>
				<%}else{%>
					<li title="이전 페이지 없음" style="color:gray">◀◀</li>	
				<%} 
				if(pageNum>1){
				%>
					<li title="이전페이지"><a href="javascript:searchWord(<%=pageNum-1%>)">◀</a></li>
				<%}else{ %>
					<li title="이전페이지 없음">◀</li>
				<%} 
				for(int i =startPage;i<startPage+onePageCnt;i++){
					if(i==pageNum){%>
						<li style="border:1px solid red"><a href="javascript:searchWord(<%= i%>)"><%=i %></a></li>
					<%}else{%>
						<li><a href="javascript:searchWord(<%= i%>)"><%=i %></a></li>
					<%}
					if(i>=totalPageSize){break;}
				}
				if(pageNum==totalPageSize){%>		
					<li title="다음페이지 없음">▶</li>
				<%}else{%>
					<li title="다음페이지"><a href="javascript:searchWord(<%=pageNum+1%>)">▶</a></li>
				<%}
				if(startPage+onePageCnt>totalPageSize){%>
					<li title="다음5페이지 없음" style="color:gray">▶▶</li>	
				<%}else{%>
					<li title="다음5페이지"><a href="javascript:searchWord(<%=startPage+onePageCnt%>)">▶▶</a></li>
				<%}%>
			</ul>
			<br/>
			<div id="searchFrm">
				<form name="search" method="get" action="myCommun.jsp" >
					<select name="searchKey" id="searchKey">
						<option value="hdname" <%if(searchKey.equals("hdname")){out.println("selected");} %>>머리글</option>
						<option value="subject" <%if(searchKey.equals("subject")){out.println("selected");} %>>제목</option>
						<option value="userId" <%if(searchKey.equals("userId")){out.println("selected");} %>>글쓴이</option>
					</select>
					<input type="text" name="searchWord" id="searchWord" value="<%= searchWord%>">
					<input type="submit" value="검색">
					<input type="hidden" name="num" value="<%=pageNum%>" id="num">
					<input type="hidden" name="imgnum" value="<%=imgpageNum%>" id="imgnum">
					<input type="hidden" name="dong" value="<%=dong%>" id="dong">
					<input type="hidden" name="gu" value="<%=gu%>" id="gu">
					<input type="hidden" name="id" value="<%=id%>" id="id">
				</form>
			</div>
		</div>
		
		<div id="imgBoard">
		<hr>
			<label>이미지</label>
			<ul id="imgShow">
				<%
				for(int i=0;i<imgfiles.size();i++){
					ListVO lv1=imgfiles.get(i);
					String[] img = new String[3];
					img = lv1.getFilename();
					int num= lv1.getNum();
					if(img[0]!=null && img[0]!="")out.print("<li><a href='javascript:readBoardGo("+num+")'><img style=\'width:200px;height:140px;padding:0px;margin:0px\'src='"+request.getContextPath()+"/team/imgfiles/"+img[0]+"'/></a></li>");
				}
				%>
			</ul>
			<div id="navi2">
				<ul id="imgpageList">
				<% if(imgstartPage>1){%>
					<li title="이전5페이지"><a href="javascript:imgsearchWord(<%=imgstartPage-imgonePageCnt %>)">◀◀</a></li>
				<%}else{%>
					<li title="이전 페이지 없음" style="color:gray">◀◀</li>	
				<%} 
				if(imgpageNum>1){
				%>
					<li title="이전페이지"><a href="javascript:imgsearchWord(<%=imgpageNum-1%>)">◀</a></li>
				<%}else{ %>
					<li title="이전페이지 없음">◀</li>
				<%} 
				for(int i =imgstartPage;i<imgstartPage+imgonePageCnt;i++){
					if(i==imgpageNum){%>
						<li style="border:1px solid red"><a href="javascript:imgsearchWord(<%= i%>)"><%=i %></a></li>
					<%}else{%>
						<li><a href="javascript:imgsearchWord(<%= i%>)"><%=i %></a></li>
					<%}
					if(i>=imgtotalPageSize){break;}
				}
				if(imgpageNum==imgtotalPageSize){%>		
					<li title="다음페이지 없음">▶</li>
				<%}else{%>
					<li title="다음페이지"><a href="javascript:imgsearchWord(<%=imgpageNum+1%>)">▶</a></li>
				<%}
				if(imgstartPage+imgonePageCnt>imgtotalPageSize){%>
					<li title="다음5페이지 없음" style="color:gray">▶▶</li>	
				<%}else{%>
					<li title="다음5페이지"><a href="javascript:imgsearchWord(<%=imgstartPage+imgonePageCnt%>)">▶▶</a></li>
				<%}%>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>