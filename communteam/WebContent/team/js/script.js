$(function (){
		$("#userId").keyup(function()
							{
								$("#idChk").val("1");
							});

		$("#frm").submit(function(){
			var c = false;
			var n = false;
			var a = false;
			if($("#userId").val()==null||$("#userId").val()==""){
				alert("아이디를 입력하세요");
				$("#userId").focus();
				return false;
			}
			if($("#userId").val().length<4){
				alert("아이디는 4글자 이상이여야 됩니다.");
				$("#userId").focus();
				return false;
			}
			if($("#idChk").val()=="1"){
				alert("중복확인 하시오");
				$("#userId").focus();
				return false;
			}
			for(i=0;i<$("#userId").val().length;i++){
				var s = $("#userId").val().charCodeAt(i);
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
				$("#userId").focus();
				return false;
			}
			if(!(n)){
				alert("아이디에 숫자가 없습니다.");
				$("#userId").focus();
				return false;
			}
			if(a){
				alert("아이디에 영문자와 숫자만 입력가능합니다.");
				$("#userId").focus();
				return false;
			}
			if($("#pass").val()==null||$("#pass").val()==""){
				alert("비밀번호를 입력하세요");
				$("#pass").focus();
				return false;
			}
			if($("#pass").val().length<4){
				alert("비밀번호는 4글자 이상이여야 됩니다.");
				$("#pass").focus();
				return false;
			}
			if($("#passChk").val()==null||$("#passChk").val()==""){
				alert("비밀번호확인를 입력하세요");
				$("#passChk").focus();
				return false;
			}
			if($("#passChk").val()!=$("#pass").val()){
				alert("비밀번호가 일치 하지 않습니다.");
				$("#pass").val("");
				$("#passChk").val("");
				$("#pass").focus();
				return false;
			}/*
			if($("#userName").val()==null||$("#userName").val()==""){
				alert("이름를 입력하세요");
				$("#userName").focus();
				return false;
			}
			if($("#year").val()==null||$("#year").val()==""){
				alert("생년월일를 입력하세요");
				$("#year").focus();
				return false;
			}
			if(!($("#gender1").prop("checked"))&&!($("#gender2").prop("checked"))){
				alert("성별를 입력하세요");
				return false;
			}
			if($("#mail").val()==null||$("#mail").val()==""){
				alert("메일를 입력하세요");
				$("#mail").focus();
				return false;
			}
			if(!($("#mailChk1").prop("checked"))&&!($("#mailChk2").prop("checked"))){
				alert("메일 수신 여부를 선택 해주세요");
				return false;
			}
			if($("#addrNum1").val()==null||$("#addrNum1").val()==""){
				alert("우편번호를 입력하세요");
				$("#addrNum1").focus();
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
			if(!($("#hobby1").prop("checked"))&&!($("#hobby2").prop("checked"))&&!($("#hobby3").prop("checked"))&&!($("#hobby4").prop("checked"))&&!($("#hobby5").prop("checked"))&&!($("#hobby6").prop("checked"))&&!($("#hobby7").prop("checked"))){
				alert("취미를 선택 해주세요");
				return false;
			}*/
			//alert("등록완료");
		})
	});