<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery.min.js"></script>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<style type="text/css">
li {
	list-style-type: none;
}

.pageHead {
	text-align: center;
}

.content {
	margin: 20px 0;
}

.findBox {
	border-radius: 5px;
	width: 200px;
	height: 30px;
	margin: 5px 0;
	height: 30px;
}

.findBtn {
	border-radius: 30px;
	width: 100px;
	height: 30px;
	margin: 5px 0;
}
</style>
<script type="text/javascript">
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
							},
							error : function() {
								alert("통신실패")
							}
						});
					} else {
						emailSpan.html("존재하지 않는 이메일 입니다.");
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
		var email = $("#opt_email").val();
		var pwchk = $("#pwchk");
		if (ran == eran) {
			eSpan.html("인증완료!");
			$
					.ajax({
						type : "POST",
						url : "login.do?command=findPassword&email=" + email,
						dataType : "text",
						success : function() {
							var message = "<b>비밀번호를 이메일로 보내드렸습니다.</b> <br/><input type='button' class='btn checkBtn' value='창 닫기' onclick='closeWD()'>";
							eSpan.html(message);
						},
						error : function() {
							alert("통신실패")
						}
					});
		} else {
			eSpan.html("다시 확인해주세요!");
		}
	}
	function closeWD() {
		close();
	}
</script>
</head>
<body>
	<section class="content">
		<h1 class="pageHead">비밀번호 찾기</h1>
		<ul>
			<li><input class="findBox" type="text" id="opt_email"
				name="opt_email" size="25"> <input class="findBtn" type="button"
				value="이메일 인증" onclick="emailChk()"><br> <span
				id="emailSpan"></span></li>
			<li><input class="findBox" type="text" id="emailConfirm"
				size="25"> <input class="findBtn" type="button" value="확인"
				onclick="emailCon()"><br> <span id="emailConSpan"></span></li>
			<li><span id="pwchk"></span></li>

		</ul>
	</section>
	<h2 class="pageHead">
		<img alt="로고사진" src="./image/Logo.png">
	</h2>
</body>
</html>