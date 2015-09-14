<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ page import ="team.CommunDAO" %>
<%@ page import ="team.ZipVO" %>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="member" class="team.ListVO" scope="page"/>
<jsp:setProperty name="member" property="*"/>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.3.min.js"></script>

    <%
	CommunDAO cd = new CommunDAO();
	ZipVO cv = new ZipVO();
	List<ZipVO> dataList = new ArrayList<ZipVO>();
	cd.zipSearch(dataList);
	List<ZipVO> dataList2 = new ArrayList<ZipVO>();
	String gu  = request.getParameter("gu");
	if(gu==null || gu ==""){
		gu = "용산구";
	}
	cd.zipSearch2(dataList2, gu);	
	
%>
<script>

$(function(){
	
	$("#lobtn1").on('change',function(){
	 	location.href="<%=request.getRequestURI()%>?gu="+$('#lobtn1').val();});
});
function getAddr(){
	
	var addr = document.getElementById("hide2").value;
	var gu = document.getElementById("lobtn1").value;
	
	location.href="communFinding.jsp?dong="+addr+"&gu="+gu;
}


</script>
<style>
	#mylocalShow ul{list-style-type:none;padding:0px;margin:0px}
</style>
		<nav> 
			<ul>
				<!--2015.09.04 12시 수정시작 -->
				<%
					if(session.getAttribute("loginCheck")==null || session.getAttribute("loginCheck").equals("N")){
				%>
						<li class="nav_li" id="mylocal_bf">지역찾기</li>
				<%
					}else if(session.getAttribute("loginCheck")!=null && session.getAttribute("loginCheck").equals("Y")){
				%>
						<li class="nav_li" id="mylocal_af">내지역보기▼</li>
				<%} %>
				<!--2015.09.04 12시 수정 끝 -->
				
				<li class="nav_li">서울시</li>	
				<li class="nav_li">
				<form method="get" action="index.jsp">
				 <select class="nav_li" id="lobtn1" name="gu" size="1">
				 	<%for(int i=0; i<dataList.size(); i++){
							cv = dataList.get(i);
							if(cv.getGu()!=null){%>
								<option value="<%=cv.getGu()%>" <%if(gu.equals(cv.getGu())){out.println("selected");} %>><%=cv.getGu()%></option>
						<%	}
						} %>
				 </select>
				 </form>
				</li>
			
				<li class="nav_li">
					 <select class="nav_li"  id="hide2" name="dong" size="1">
							<%for(int a=0; a<dataList2.size(); a++){
								cv = dataList2.get(a);
								if(cv.getDong()!=null){
								%>
								<option value="<%=cv.getDong() %>"><%=cv.getDong() %></option>
							<%}
							} %>		 
					 </select>
				</li>
				
				<button id="searchbtn" onClick="getAddr()">검색</button>
				
			</ul>
		</nav>