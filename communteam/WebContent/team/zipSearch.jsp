<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team.CommunDAO" %>
<%@ page import="team.ZipVO" %>
<%
	ZipVO mv = new ZipVO();
	CommunDAO md = new CommunDAO();
	
	request.setCharacterEncoding("UTF-8"); 
	
	mv.setAddr1(request.getParameter("doro"));//request한 도로명
	
	List<ZipVO> lst = new ArrayList<ZipVO>();
	if(mv.getAddr1()!=null && mv.getAddr1() !=""){
		//검색
		lst = md.zipcodeSearch(mv);		
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<script>
	function zipChk(){
		doro = document.getElementById("doro").value;
		if(doro==null || doro==""){
			alert("도로명을 입력후 검색하세요");
			return false;
		}
		document.zipFrm.submit();
	}
	function zipSet(zipCode, addr1){
		opener.document.frm.zipCode.value=zipCode;
		opener.document.frm.addr1.value=addr1;
		self.close();
	}
</script>
</head>
<body>
<div>
	<form name="zipFrm" method="post" action="zipSearch.jsp">
		<label>도로명입력</label>
		<input type="text" name="doro" id="doro" >
		<input type="button" value="주소검색" onClick="zipChk()">
	</form>
	<hr>
	<ul>
	<%
		if(lst==null || lst.size()==0){
			
	
	%>
		<li></li><li>검색결과 따위는 존재하지 않았다........</li>
	<%}else{ 
		for(int i=0; i<lst.size();i++){
			ZipVO mvResult = lst.get(i);
		%>
		<li onClick="zipSet('<%=mvResult.getZipCode()%>','<%=mvResult.getAddr1()%>')"><%=mvResult.getZipCode() %></li>
		<li onClick="zipSet('<%=mvResult.getZipCode()%>','<%=mvResult.getAddr1()%>')"><%=mvResult.getAddr1() +" "+mvResult.getAddr2() %></li>
	<% }
	}
	%>	
		
	</ul>
</div>
</body>
</html>