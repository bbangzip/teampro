<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import ="team.CommunDAO" %>
<%@ page import ="team.ListVO" %>

    <jsp:useBean id="myBean" class="team.ListVO" scope="page"/>
    <jsp:setProperty name="myBean" property="*"/>
<%
	CommunDAO cd = new CommunDAO();

	String gu = request.getParameter("gu");
	String dong = request.getParameter("dong");
	
	String id=(String)session.getAttribute("userId");
	int num = Integer.parseInt(request.getParameter("num"));
	
	ListVO chodata = cd.getLiData(id, num);
	ListVO imgfile = cd.getImage(dong,num);
	
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/write_readboard.css"/>
<script src="js/jquery-1.11.3.min.js"> </script>

</head>
<body>
<%@ include file="pageLock.jspf" %>
<!-- 배너부분 -->


<div id="main">
<!-- 본문부분 -->
<section>
<form  name="writefrm" action="editBoard.jsp?num=<%=chodata.getNum() %>" method="post">
	<div id="listbox">
		<input type="hidden" name="userId" value="<%=id%>"/>
		<input type="hidden" name="num" value="<%=chodata.getNum()%>"/>
		<input type="hidden" id="location" name="location" value="<%=chodata.getLocation()%>"/>
		<ul id="list">
			<li>머리글</li> 
			
			<li>
	
				<select name="hdName">
				  <option value="<%=chodata.getHdName() %>"><%=chodata.getHdName()%></option>
				  
				</select>

			</li>
			<li>제목</li>
			<li><input type="text" name="subJect" maxlength="20" size="30" readonly	value="<%=chodata.getSubJect() %>"></li>
			<li>내용</li>
			<li><textarea rows="6" name="content" cols="50" readonly><%=chodata.getContent() %></textarea></li>

	
		</ul>
	</div>
	<div id="pics">
		<ul id="imgShow">
			<%
				String[] img =imgfile.getFilename();
			for(int i=0;i<imgfile.getFilename().length;i++){		
				if(img[i]!=null && img[i]!="")out.print("<li style='position:relative;padding:0px;margin:0px'><img style=\'width:600px;height:300px\'src='"+request.getContextPath()+"/team/imgfiles/"+img[i]+"'/></li>");
			}
			%>
		</ul>
	</div>
	<div id="map"></div>
<script src="//apis.daum.net/maps/maps3.js?apikey=ba13e8077519821f8fa76f20d6d6577a"></script>
<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng<%=chodata.getLocation()%>, // 지도의 중심좌표 //DB에서 받아와야함.
        level: 3 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new daum.maps.LatLng<%=chodata.getLocation()%>; //DB에서 받아와야 함. 

// 마커를 생성합니다
var marker = new daum.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);


function goback(){
	history.go(-1);
}
</script>


</section>

<div id="buttonbox">
	<div id="bottonbox_inside">
		<input type="submit" value="수정" style="width:80px">
		<input type="button" value="확인" style="width:80px" 
				onClick="goback()">
				
	</div>
</div>
</form>
</div>
</body>
</html>