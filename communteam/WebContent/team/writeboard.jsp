<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import ="team.CommunDAO" %>
<%@ page import ="team.ListVO" %>

    <jsp:useBean id="member" class="team.ListVO" scope="page"/>
    <jsp:setProperty name="member" property="*"/>
<%
	String gu = request.getParameter("gu");
	String dong = request.getParameter("dong");
	
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/writeboard.css"/>
<script src="js/jquery-1.11.3.min.js"> </script>

</head>
<body>
<%@ include file="pageLock.jspf" %>
<!-- 배너부분 -->
		

<div id="main">
<!-- 본문부분 -->
<section>
<!-- -------------------------------------------------------멀티파트 수정 -->
<form  name="writefrm" action="imgdata.jsp" method="post" enctype="multipart/form-data">
	<div id="listbox">
		<input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>"/>
		<input type="hidden" id="location" name="location"/>
		<ul id="list">
			<li>머리글</li> 
			
			<li>
				<select name="hdName" id="hdName">
				  <option value="식재료" selected>식재료</option>
				  <option value="밥먹어요" >밥먹어요</option>
				  <option value="놀아요" >놀아요</option>
				</select>

			</li>
			<li>제목</li>
			<li><input type="text" name="subJect" maxlength="20" size="30" minlength="1" required title="최소 1글자 이상적으셔야합니다."></li>
			<li>내용</li>
			<li><textarea rows="6" name="content" cols="50" maxlength="500" minlength="1" required title="최소 1글자 이상적으셔야합니다."></textarea></li>
			<li>비밀번호</li>
			<li><input type="text" name="listPwd" size="30" maxlength="12"  minlength="4" required title="최소 4글자 이상적으셔야합니다."></li></li>
			<li>이미지1</li>
			<li><input type="file" name="filename1" id="filename1"/></li>
			<li>이미지2</li>
			<li><input type="file" name="filename2" id="filename2"/></li>
			<li>이미지3</li>
			<li><input type="file" name="filename3" id="filename3"/></li>
			<li>위치</li>
			<li>서울시
				<input type="hidden"  value="<%=gu %>">|<%=gu %>
				<input type="hidden" name="dong" value="<%=dong %>">|<%=dong%> 
			</li>
			
		</ul>
	</div>
<!-- 지도가 시작되는 영역 -------------------------------------------------------------------->
	<div id="map"></div>

<script src="//apis.daum.net/maps/maps3.js?apikey=ba13e8077519821f8fa76f20d6d6577a&libraries=services"></script>
<script>



// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addr2coord('<%=dong %>', function(status, result) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {
		
    	// 지도를 표시할 div
    	 var mapContainer = document.getElementById('map'),  
    	    mapOption = {
    	        center: new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng), // 지도의 중심좌표
    	        level: 2 // 지도의 확대 레벨
    	    };  

    	 // 지도를 생성합니다    
    	 var map = new daum.maps.Map(mapContainer, mapOption); 
    	 

    	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
    	var zoomControl = new daum.maps.ZoomControl();
    	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
    	 
    	 
    	 // 지도의 현재 중심좌표를 얻어옵니다 
    	 var center = map.getCenter(); 
      	 document.getElementById("location").value= center; //일단 중심좌표값을 location에 저장
    	 
        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords });

     	// 마커가 드래그 가능하도록 설정합니다 
        marker.setDraggable(true);
     }
    
  	 //마커 드래그가 끝나면 이벤트를 발생시킨다.
    daum.maps.event.addListener(marker, 'dragend', function(mouseEvent) {        
     var latlng =  marker.getPosition(); // 마커의 위치를 latlang에 저장한다.
  	 document.getElementById("location").value= latlng; 
   
    });
});


	function goback(){
		history.go(-1);
	}
</script>
</section>

<!-- 원하는 위치로 이동하세요 안내box-->
<div id="map_popup"> 
	원하시는 위치로 이동하세요
</div>

<!-- 버튼이 시작되는 영역 -------------------------------------------------------------------->
<div id="buttonbox">
	<div id="bottonbox_inside">
		<input type="submit" value="완료" style="width:80px">
		<input type="reset" value="초기화" style="width:80px">
		<input type="button" value="취소" style="width:80px" onClick="goback()">
		
	</div>
</div>
</form>
</div>
</body>
</html>