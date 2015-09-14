<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title here</title>
<!-- style ------------------------------------------------------------------------------------------------------->
<style>
body{padding:0px;margin:0px}
	#mainbox{width:1000px; /*가운데 정렬용 박스*/
			 heigth:1000px;
			 position:relative;
			 background-color:yellow;
			 margin-left:-500px;
			 left:50%}
	
	#listbox{width:600px; /*내용을 쓸 박스의 가운데 정렬용 박스*/
			 height:350px;  
			 border:1px solid gray; 
			 position:relative; 
			 left:50%;
			 top:0px; 
			 margin-left:-300px;}
			 
		#list{ list-style-type:none;} /*타이틀 li의 표시형식을 제거함*/
		#list li:nth-child(2n+1) {width:100px; /*타이틀  li*/ 
								  float:left; 
								  text-align:right; 
								  line-height:50px; 
								  padding-right:5px;}
		#list li:nth-child(2n) {line-height:50px;} /*각종 input box*/
	
	#mapbox{width:600px;  /*구글맵용공간*/
			height:300px; 
			border:1px solid gray; 
			position:relative;
			top:0px; 
			left:50%; 
			margin-left:-300px; }

	#buttonbox{width:600px; /*버튼박스를 담을 중앙정렬용 상자*/ 
			   border:1px solid gray; 
			   height:80px;
			   position:relative; 
			   top:0px; 
			   left:50%; 
			   margin-left:-300px;}
	#buttonbox>input{width:80px;
					position:relative;
					left:30%;
					top:40%;}
</style>


<!-- script----------------------------------------------------------------------------------------------------------->

<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="/js/jquery-1.11.3.min.js"> </script>
<script src="/js/jquery.gmap.js"></script>



<script>
	$(function(){
		
		$('#mapbox').gMap({
		address:'korea 선유도', //< session.getAttribute("localname"); %>
		maptype:'ROADMAP',//ROADMAP, HYBRID,SATELLITE, TERRAIN
		zoom:11,
		markers:[
			        {latitude:37.559715, longitude:126.975244,html:"_latlng"},
			        {address:"korea 선유도",html:"_address"},
				],
		controls:{
				panControl:false,
				zoomControl:true,
				mapTypeControl:true,
				scaleControl:true,
				streetViewControl:true,
				overviewMapControl:true,
		}
		});
	});
</script>



</head>
<!-- ------------------------------------------------------------------------------------------------->
<!-- body -------------------------------------------------------------------------------------------->
<body>
<div id="mainbox">

<!-- 배너부분 ------------------------------------------------------------------------------------------>
<div id="Banner">
	<!--  %@ include file="/include/header.jsp" %-->	
</div>

<!-- 본문부분 ------------------------------------------------------------------------------------------>
<section>
	<div id="listbox">
		<ul id="list">
			<li>머리글</li>
			<li>
				<select>
				  <option value="food">식재료</option>
				  <option value="eat">밥먹어요</option>
				  <option value="meet">만나요</option>
				  <option value="play">놀아요</option>
				</select>
  
			</li>
			<li>제목</li>
			<li><input type="text" maxlength="20" size="30"></li>
			<li>내용</li>
			<li><textarea rows="6" cols="50"></textarea></li>
			<li>이미지</li>
			<li><input type="file" size="30"></li>
			<li>위치</li>
		</ul>
	</div>
	<div id="mapbox" ></div> <!-- 이곳은 구글맵이 들어가는 부분입니다. ----------------------------------------- -->
</section>

<div id="buttonbox">
		<input type="button" value="완료">
		<input type="button" value="수정">
		<input type="reset" value="취소">
</div>


</div>
</body>
</html>





