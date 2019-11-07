<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery.min.js"></script>
<!-- jquery api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 다음 주소 api -->
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<!-- 달력 api -->
<link href="css/updateuser.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<meta charset="UTF-8">
<title>register</title>
</head>
<script type="text/javascript">
	var userPW = "${memdto.opt_pw }";
	console.log(userPW);
	function validate() {
		var re = /^[a-zA-Z0-9]{4,12}$/; // 아이디와 패스워드가 적합한지 검사할 정규식
		var re2 = /^[a-zA-Z0-9]{4,15}$/; // 이메일이 적합한지 검사할 정규식

		var pw = $("#opt_pw").val();
		var email = $("#opt_email").val();

		if (update.opt_pw.value == "") {
			alert("비밀번호를 입력해 해주세요");
			update.opt_id.focus();
			return false;
		}

		if (pw != userPW) {
			alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
			update.checkpw.value = "";
			update.checkpw.focus();
			return false;
		}

		if (update.opt_name.value == "") {
			alert("이름을 입력해 주세요");
			update.opt_name.focus();
			return false;
		}

		if (update.opt_birth.value == "") {
			alert("생년월일 입력해 주세요");
			update.opt_birth.focus();
			return false;
		}
		if (update.opt_phone.value == "") {
			alert("전화번호를 입력해 주세요");
			update.opt_phone.focus();
			return false;
		}
		if (update.opt_addr.value == "") {
			alert("주소 입력해 주세요");
			update.opt_addr.focus();
			return false;
		}

		if (email.value == "") {
			alert("이메일을 입력해 주세요");
			email.focus();
			return false;
		}
		if (emailConfirm.value == "") {
			alert("이메일 인증을 해주세요");
			emailConSpan.focus();
			return false;
		}

		if (!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
			return false;
		}

		close();
	}

	function check(re, what, message) {
		if (re.test(what.value)) {
			return true;
		}
		alert(message);
		what.value = "";
		what.focus();
	}

	var ran = null;
	
	function emailChk() {
		var email = $("#opt_email").val();
		var emailSpan = $("#emailSpan");

		$.ajax({
			type : "POST",
			url : "login.do?command=ChkEmail&email=" + email,
			dataType : "text",
			success : function(data) {
				var trm = $.trim(data);
				if (email.length != 0) {
					if (trm == email) {
						$.ajax({
							type : "POST",
							url : "login.do?command=sendEmail&email=" + email,
							dataType : "text",
							success : function(data) {
								ran = $.trim(data);
								emailSpan.html("인증번호가 발송되었습니다.");
								console.log(ran);
							},
							error : function() {
								alert("통신실패")
							}
						});
					} else {
						emailSpan.html("이미 존재하는 이메일 입니다.");
					}

				} else {
					emailSpan.html("이메일을 입력해 주세요.");
				}
			},
			error : function() {
				alert("통신실패")
			}
		});
	}

	function emailCon() {
		var eran = $("#emailConfirm").val();
		var eSpan = $("#emailConSpan");
		if (ran == eran) {
			eSpan.html("인증완료!");
		} else {
			eSpan.html("다시 확인해주세요!");
		}
	}

	function DaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var fullRoadAddr = data.roadAddress;
				var extraRoadAddr = '';
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

				document.getElementById('postcode').value = data.zonecode;
				document.getElementById('roadAddress').value = fullRoadAddr;
			}
		}).open();
	}

	$(function() {
		$("#opt_birth").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	})
</script>
<body>
	<div class="update_content">
	<h2>개인정보 수정</h2>
	<h4>개인정보를 수정하려면 비밀번호와 이메일 인증이 필수입니다</h4>
	<form action="login.do" id="updateFrm" method="post" name="update" onsubmit="return validate()">
		<input type="hidden" name="command" value="updateUser" /> 
		<input type="hidden" name="opt_id" value="${memdto.opt_id }" /> 
		<input type="hidden" id="userEmail" value="${memdto.opt_email }" /> 
		<input type="hidden" name="opt_gender" value="${memdto.opt_gender }" />
		<div class="update_area">
		<table>
			<tr>
				<td><b>비밀번호</b></td>
				<td><input type="password" id="opt_pw" class="input_text" name="opt_pw" size="25" placeholder="비밀번호를 입력해주세요"></td>
			</tr>
			<tr>
				<td><b>이 름</b></td>
				<td><input type="text" id="opt_name" class="input_text"  name="opt_name" size="25" value="${memdto.opt_name }"></td>
			</tr>
			<tr>
				<td><b>생년월일</b></td>
				<td><input type="text" id="opt_birth" class="input_text" name="opt_birth" size="25" value="${memdto.opt_birth }"></td>
			</tr>
			<tr>
				<td><b>전화번호</b></td>
				<td><input type="text" id="opt_phone" class="input_text"  name="opt_phone" size="25" value="${memdto.opt_phone }"></td>
			</tr>
			<tr>
				<td><b>주 소</b></td>
				<td><input type="text" id="postcode" class="post_text margin-bottom-5px" name="postcode" placeholder="우편번호" readonly="readonly" size="25" >
				 	<input type="button" value="우편번호 찾기" class="btn post_btn" onclick="DaumPostcode()">
					<input type="text" id="roadAddress" class="input_text margin-bottom-5px" name="roadAddress" placeholder="도로명주소" readonly="readonly" size="25">
					<input type="text" name="opt_addr" class="input_text" checked="checked" placeholder="상세주소" size="25" /></td>
			</tr>
			<tr>
				<td><b>이메일</b></td>
				<td><input type="text" id="opt_email" name="opt_email" class="email_text" value="${memdto.opt_email }"> 
					<input type="button" value="이메일 인증" onclick="emailChk()" class="btn email_btn"> 
					<span id="emailSpan"></span>
				</td>
			</tr>
			<tr>
				<td><b>인증번호</b></td>
				<td><input type="text" id="emailConfirm" class="confrim_text" size="25">
					<input type="button" value="확인" onclick="emailCon()" class="btn confrim_btn"> 
					<span id="emailConSpan"></span></td>
			</tr>
		
		</table>
				<input type="submit" value="정보수정" class="update_btn">
		</div>
	</form>
	</div>
</body>
</html>