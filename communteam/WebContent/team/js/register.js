$(function (){
		$("#Id").keyup(function(){
			$("#idChk").val("1");
		});
		$("#registerChk").submit(function(){
			var c = false;
			var n = false;
			var a = false;
			if($("#Id").val()==null||$("#Id").val()==""){
				alert("아이디를 입력하세요");
				$("#Id").focus();
				return false;
			}
			if($("#idChk").val()=="1"){
				alert("아이디 중복확인을 하셔야 합니다.");
				$("Id").focus();
				return false;
			}	
			if($("#Id").val().length<8){
				alert("아이디는 8글자 이상이여야 됩니다.");
				$("#Id").focus();
				return false;
			}
			for(i=0;i<$("#Id").val().length;i++){
				var s = $("#Id").val().charCodeAt(i);
				if(s>=65&&s<=90||s>=97&&s<=122){
					c=true;
				}else if(s>=48&&s<=57){
					n=true;
				}else{
					a=true;
				}
			}
			if(!(c)){
				alert("아이디에 영문자가 없습니다.");
				$("#Id").focus();
				return false;
			}
			if(!(n)){
				alert("아이디에 숫자가 없습니다.");
				$("#Id").focus();
				return false;
			}
			if(a){
				alert("아이디에 영문자와 숫자만 입력가능합니다.");
				$("#Id").focus();
				return false;
			}
			if($("#pass").val()==null||$("#pass").val()==""){
				alert("비밀번호를 입력하세요");
				$("#pass").focus();
				return false;
			}
			if($("#pass").val().length<8){
				alert("비밀번호는 8글자 이상이여야 됩니다.");
				$("#pass").focus();
				return false;
			}
			if($("#passCheck").val()==null||$("#passCheck").val()==""){
				alert("비밀번호확인를 입력하세요");
				$("#passCheck").focus();
				return false;
			}
			if($("#passCheck").val()!=$("#pass").val()){
				alert("비밀번호가 일치 하지 않습니다.");
				$("#pass").val("");
				$("#passCheck").val("");
				$("#pass").focus();
				return false;
			}
			if($("#name").val()==null||$("#name").val()==""){
				alert("이름를 입력하세요");
				$("#name").focus();
				return false;
			}
			if($("#email").val()==null||$("#email").val()==""){
				alert("메일를 입력하세요");
				$("#email").focus();
				return false;
			}
			if($("#zipCode").val()==null||$("#zipCode").val()==""){
				alert("우편번호를 입력하세요");
				$("#zipCode").focus();
				return false;
			}
			if($("#addr1").val()==null||$("#addr1").val()==""||$("#addr2").val()==null||$("#addr2").val()==""){
				alert("주소를 입력하세요");
				$("#addr1").focus();
				return false;
			}
			if($("#tel2").val()==null||$("#tel2").val()==""||$("#tel3").val()==null||$("#tel3").val()==""){
				alert("전화번호를 입력하세요");
				$("#tel2").focus();
				return false;
			}

		})
	});