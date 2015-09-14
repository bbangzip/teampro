<%@page import="team.CdataDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import ="team.CommunDAO" %>
<%@ page import ="team.ListVO" %>

    <jsp:useBean id="member" class="team.ListVO" scope="page"/>
    <jsp:setProperty name="member" property="*"/>
<%
	CommunDAO cd = new CommunDAO();
	CdataDAO cdd = new CdataDAO();
	
	String gu = request.getParameter("gu");
	String dong = request.getParameter("dong");
	
	String id=(String)session.getAttribute("userId");
	int num = Integer.parseInt(request.getParameter("num"));
	ListVO chodata = cd.getLiData(id, num);
	ListVO imgfile = cd.getImage(dong,num);
	cdd.select(member); 
	String file[]= member.getFilename();
%>  
<!DOCTYPE html>
<html>
<head>

<style>
	body{padding:0px;margin:0px}
	#main{width:1000px; 
		  heigth:1300px;
		  margin-left:50%;
		  left:-500px;
		  position:relative;
		  top:0px;}
	
	#listbox{width:600px; 
			 height:550px; 
			 position:relative; 
			 left:50%; 
			 margin-left:-300px; 
			 top:0px;
			 border:1px solid gray;
			 background-color:#D3E1EB;}
		#list{ list-style-type:none;}
		#list li:nth-child(2n+1) {width:100px; float:left; text-align:right; line-height:50px; padding-right:5px;}
		#list li:nth-child(2n) {line-height:50px;}
	
	#map {position:relative;
				top:0px;
				left:50%;
				margin-left:-300px;
				width:600px;
				height:300px}

	
	#buttonbox{width:600px; 
			   height:80px; 
			   position:relative;
			   top:0px; 
			   left:50%; 
			   margin-left:-300px;
			   }
	#bottonbox_inside{width:260px;
					  height:40px; 
					  position:relative;
					  top:20px; 
					  left:50%;
					  margin-left:-130px }
</style>
<script src="js/jquery-1.11.3.min.js"> </script>
<script>
function fileRemove(point){//파일 삭제시 변경
	
	var objDiv = document.getElementById("divFile"+point);//div
	objDiv.style.display = "none";
	
	var obj = document.getElementById("filename"+point);//hidden
	obj.type="file";
	obj.value="";
	
}
</script>
</head>
<body>
<%@ include file="pageLock.jspf" %>
<!-- 배너부분 -->	

<div id="main">
<!-- 본문부분 -->
<section>
<!-- -------------------------------------------------------멀티파트 수정 -->
<form  name="writefrm" action="imgdataEdit.jsp?num=<%=member.getNum()%>&gu=<%=member.getGu()%>&dong=<%=member.getDong()%>" method="post" enctype="multipart/form-data">
	<div id="listbox">
		<input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>"/>
		<input type="hidden" id="location" name="location" value="<%=member.getLocation()%>"/>
		<input type="hidden" id="num" name="num" value="<%=member.getNum()%>"/>
		<input type="hidden" id="gu" name="gu" value="<%=member.getGu()%>"/>
		<input type="hidden" id="dong" name="dong" value="<%=member.getDong()%>"/>
		
		<ul id="list">
			<li>머리글</li> 
			
			<li>
				<select name="hdName" id="hdName">
				  <option value="식재료" <%if(member.getHdName().equals("식재료"))out.println("selected");%>>식재료</option>
				  <option value="밥먹어요" <%if(member.getHdName().equals("밥먹어요"))out.println("selected");%> >밥먹어요</option>
				  <option value="놀아요" <%if(member.getHdName().equals("놀아요"))out.println("selected"); %>>놀아요</option>
				</select>

			</li>
			<li>제목</li>
			<li><input type="text" name="subJect" value="<%=member.getSubJect()%>" maxlength="20" size="30" minlength="1" required title="최소 1글자 이상적으셔야합니다."></li>
			<li>내용</li>
			<li><textarea rows="6" name="content" cols="50" maxlength="500" minlength="1" required title="최소 1글자 이상적으셔야합니다."><%=member.getContent() %></textarea></li>
			<li>비밀번호</li>
			<li><input type="text" name="listPwd" size="30" maxlength="12"  minlength="4" required title="최소 4글자 이상적으셔야합니다."></li></li>
			<li>이미지</li>
			<li>
				<%
				for(int i=0;i<file.length;i++){
					if(file[i]!=null&&file[i]!=""){
						out.println("<div id='divFile"+(i+1)+"'>"+file[i]+"<input type='button' value='삭제' onClick='fileRemove("+(i+1)+")'/></div>");							
					}
				}
				
				for(int j=0;j<file.length;j++){
					if(file[j]!=null&&file[j]!=""){
						out.println("<div><input type='hidden' name='filename"+(j+1)+"' id='filename"+(j+1)+"' value='"+file[j]+"'/></div>");
					}else{
						out.println("<div><input type='file' name='filename"+(j+1)+"' id='filename"+(j+1)+"'/></div>");
						
					}
					
				}
			%>
			</li>

		</ul>
	</div>

	<div id="map"></div>

<script src="//apis.daum.net/maps/maps3.js?apikey=ba13e8077519821f8fa76f20d6d6577a&libraries=services"></script>
<script>



//주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addr2coord('<%=member.getDong() %>', function(status, result) {

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
	history.go(-2);
}
</script>


</section>

<div id="buttonbox">
	<div id="bottonbox_inside">
		<input type="submit" value="수정" style="width:80px">
		<input type="button" value="취소" style="width:80px" onClick="goback()">
	</div>
</div>
</form>
</div>
</body>
</html>