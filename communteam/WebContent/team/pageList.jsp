<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team.PageVO, team.CommunDAO, team.MemberVO" %>
<%@ page import = "java.util.List" %>
<%
	CommunDAO gd = new CommunDAO();
	
	int pNum = 1;
	int rSize = 3;	
	int tPage = 1;
	int pCnt = 5;
	int pStart = 1;
	int tRecord = 0;
	
	String requestPageNum = request.getParameter("num");
	if(requestPageNum==null){
		pNum=1;
	}else{
		pNum=Integer.parseInt(requestPageNum);
		
	}
	
	tRecord = gd.recordCnt((String)session.getAttribute("userId"));
	if(tRecord % rSize ==0){
		tPage = tRecord / rSize;
	}else{
		tPage = tRecord / rSize + 1;
	}
	
	if(pNum % pCnt == 0){
		pStart = (pNum / pCnt - 1)*pCnt + 1;
		
	}else{
		pStart = (pNum / pCnt)*pCnt +1;
	}

	List<PageVO> lst = gd.select(pNum, rSize, tPage, (String)session.getAttribute("userId") );
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
function delwin(num){
	location.href="pageDel.jsp?num="+num;
}
</script>
<style>
#pWriteBtn input, #homeBtn input, #delBtn input
{background-color:#FFD9EC;border-radius:5px 5px 5px 5px}
#pList, #pWriteBtn, #txtLabel, #homeBtn, #pMain{position:absolute;}
#list li, #pList li, hr{float:left;}
#list ul, #list li, #pList ul, #pList li{padding:5px; margin:1px;list-style-type:none}
a, #pList a:link{text-decoration:none}


#delBtn{margin-left:200px;}

#list ul{width:500px;height:120px}
.lbl1{width:68px;background-color:#BDBDBD}
.result1{width:158px;background-color:#FAE0D4}
.result2{width:407px;background-color:#FAE0D4}

#pList{left:7%;width:400px;}

#pList ul{height:40px;}
#pList li{height:40px; line-height:40px;text-align:center;
			width:40px;}
#pList li:hover{background-color:#FFDFFF}
#pList a:link{color:black}
hr{width:500px;}
#a{list-style-type:none}
#pWriteBtn{left:430px;}

#txtLabel{left:170px;}
#homeBtn{font-weight:bold;font-size:10px;}
#pMain{left:25%; width:500px;}
</style>
</head>
<body>
<%@ include file="pageLock.jspf" %>
<div id="pMain">
<label id="txtLabel">쪽지 보관함 : PAGE-<%=pNum%></label><br/>
<label id="homeBtn"><input type="button" value="Main Home" onClick="location.href='index.jsp'" onMouseover="this.style.backgroundColor='#EDC7DA'" onMouseout="this.style.backgroundColor='#FFD9EC'"></label>
	
<label id="pWriteBtn"><input type="button" value="쪽지쓰기" onClick="location.href='page.jsp'" onMouseover="this.style.backgroundColor='#EDC7DA'" onMouseout="this.style.backgroundColor='#FFD9EC'"></label>


<br/>


<div id="list">
<% for(int idx=0; idx<lst.size(); idx++){
		PageVO gv = lst.get(idx);
		%>
		<ul>
		<li class="lbl1"><label>글쓴이: </label></li><li class="result1">
		<%=gv.getUserId2() %></li>
		<li class="lbl1"><label>받는이: </label></li><li class="result1">
		<%=gv.getUserId1() %></li>
		<li class="lbl1"><label>날짜: </label></li><li class="result2">
		<%=gv.getWriteDate() %></li>
		<li class="lbl1"><label>글내용: </label></li><li class="result2">
		<%=gv.getText() %></li>
		</ul>
		<div id="delBtn">
		<input type = "button" value = "삭제" onClick="delwin(<%=gv.getNum()%>)">
		</div>
<hr/>
<%}%>

</div>


<ul id = "pList">
<%if(pStart>1){%>
	<li title="이전페이지 5"><a href="pageList.jsp?num=<%=pStart-pCnt%>">◀ ◀</a></li>
	
	 <%}else{
	 	%>
	 	<li title="X">◀ ◀</li>
	 	
	 <%}
	 if(pNum>1){
	 %>
		<li title="이전페이지"><a href="pageList.jsp?num=<%=pNum-1%>">◀</a></li>
	<%}else{%>
		<li title="X">◀</li>

	<%}
	for(int i=pStart; i<pStart+pCnt; i++){
		if(i==pNum){ %>
			<li style="border:1px solid black; background-color:#E1E1E1"><a href="pageList.jsp?num=<%=i%>"><%=i%></a></li>
		<%}else{%>
			<li><a href="pageList.jsp?num=<%=i%>"><%=i%></a></li>
			
		<%}
		
		if(i>=tPage){
			break;
		}
		
	}
	
	if(pNum==tPage){%>
		<li title="다음페이지">▶</li>
		
	<%}else{%>
		<li title="다음페이지"><a href="pageList.jsp?num=<%=pNum+1%>">▶</a></li>
		
	<%}%>
	<%if(pStart+pCnt>tPage){%>
		<li title="다음페이지5">▶▶</li>
	<%}else{%>
		<li title="다음페이지5"><a href="pageList.jsp?num=<%=pStart+pCnt%>">▶▶</a></li>

	<%}%>
	</ul><br/><br/><br><br>

 </div>
 <br>

</body>
</html>