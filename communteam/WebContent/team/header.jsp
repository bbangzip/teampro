<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="Banner">
		<div id="logo"><a href="index.jsp"><img src="img/logo.jpg" alt="홈으로이동"></a></div>
		<div id="loginbox">
			<%@ include file="loginView.jspf" %>
		</div>
</div>





<style>
/*로그인박스*************************************************************************************/
	#Banner{width:100%;
			height:100px; 
			background-color:#67A2D5;
			position:absolute;}
	
	#logo {position:absolute;
		   width:370px; 
		   height:60px;  
		   left:50px; 
		   top:30px;
		   }
	
	#loginbox{width:370px; 
			  height:50px;
			  position:absolute;
			  left:63%; 
			  top:0px; 
			  z-index:2;
			  }
		#loginbox>ul{list-style-type:none; /*로그인박스 ul*/
					 margin:0px;
					 padding:0px;
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
				 		list-style-type:none; 
				 		width:100px;
				 		height:48px; 
				 		line-height:50px;
				 		text-shadow: 2px 2px  4px #000000;
					   }
			   
		#loginbox>ul>li>a:link 	  {color:white;} /*로그인 박스의 a태그*/					   
		#loginbox>ul>li>a:visited {color:white;}
		#loginbox>ul>li>a:hover   {color:red;}
		
		#loginbox>ul>li:nth-child(1) {cursor: default; width:150px;} /*사이즈맞추기위한 박스의 마우스모양을 바꿈*/
		
</style>