<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

	#bannerbox{width:100%; 
			   height:100px; 
			   background-image:url("img/night.jpg")}
	
	/*로그인박스*************************************************************************************/
	#loginbox{width:320px; 
			  height:50px; 
			  position:absolute; 
			  left:70%; 
			  z-index:2;}
		#loginbox>ul{list-style-type:none; /*로그인박스 ul*/
				 	 height:50px;  
				 	 line-height:50px;
				 	 font-family:돋움; 
				 	 font-weight:bold; 
				 	 font-size:16px;
					 }
		#loginbox>ul>li{
						float:left; /*지역검색 ul의 아래의 li */
				 		cursor: pointer;
				 		text-align:center;
				 		/*list-style-type:none;*/ 
				 		width:80px;
				 		height:48px; 
				 		line-height:50px;
					   }
		#loginbox>ul>li>a:link 	  {color:white; text-decoration: none;} /*로그인 박스의 a태그*/					   
		#loginbox>ul>li>a:visited {color:white; text-decoration: none;}
		#loginbox>ul>li>a:hover   {color:red;   text-decoration: none;}
		
		#loginbox>ul>li:nth-child(1) {cursor: default;} /*사이즈맞추기위한 박스의 마우스모양을 바꿈*/
		
		.log_bf     {display:none;	}   /*로그인전: 회원가입, 로그인*/
		.log_af     {display:block;}   /*로그인후: XX님, 로그아웃, 쪽지*/
</style>

<div id="bannerbox">
	<div id="loginbox">
		<ul>
			<li class="log_bf"></li> <!-- 크기를 맞추기위해 감춰논 li -->
			<li class="log_bf"><a href="#">회원가입</a></li>
			<li class="log_bf"><a href="#">로그인</a></li>
			<!-- 로그인 전후--------------------------------------->
			<li class="log_af"><a href="#">xxx님</a></li>
			<li class="log_af"><a href="#">로그아웃</a></li>
			<li class="log_af"><a href="#">쪽지</a></li>
		</ul>
	</div>

</div>