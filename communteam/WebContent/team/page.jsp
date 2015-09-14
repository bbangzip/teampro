<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<script src="../js/jquery-1.11.3.min.js"></script>
<script>
	$(function()
	{
		$("#pageFrm").submit(function()
				{
					if($("#userId1").val()==null || $("#userId1").val()=="")
						{
							alert("아이디를 입력하세요..");
							return false;
						}
					if($("#text").val()==null || $("#text").val()=="")
						{
							alert("내용을 입력하시오");
							return false;
						}
					
				});
	});
	
</script>
<head>
<meta charset="UTF-8">
<title>쪽지 보내기</title>
</head>
<body>
<%@ include file="pageLock.jspf" %>
<form  method="post" name="pageFrm" id="pageFrm" action="pageOk.jsp">
<h1>쪽지 보내기</h1>
<label>받는 이 : </label><input type="text" name="userId1" id="userId1"> <input type="submit" value="보내기"><br>
<input type="hidden" name="userId2" value="<%=session.getAttribute("userId")%>">
<hr>
<textarea rows="10" cols="40" name="text" id="text"></textarea><br>
</form>
</body>
</html>