<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복체크</title>
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<style type="text/css">
.btn {
    cursor: pointer;
    border: none;
    color: #fff;
    font-weight: 600;
    padding: 8.5px;
    margin-top:5px;
}
.checkBtn {
    background-color: #cbb795;
}
input[type=text] {
	   padding: 8px;
}
table {
    margin: 0 auto;
    margin-top: 15px;
   }
.hide {
	display:none;
}
</style>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
var ids = [];
	$(function() {
		$.ajax({
			type : "GET",
			url : "login.do?command=userIds",
			dataType : "Json",
			success : function(data){
				$.each(data, function(key, val){
					if(key == "id"){
						list = val;
						for(var i = 0; i < list.length; i++){
							ids[i] = list[i];
						}
					}
				})
			}
		})
	})
	console.log(ids);

	function IDvalid() {
		var re = /^[a-zA-Z0-9]{4,12}$/;
		var id = document.getElementById("id_check");
		if (re.test(id.value)) {
			return true;
		} else {
			alert("아이디는 4~12자의 영문 대소문자와 숫자로만 입력");
			id.value = "";
			id.focus();
		}
	}

	function cofirmChk() {
		var id = document.getElementById("id_check").value;
		var message = document.getElementById("checkMessage");
		if (ids.indexOf(id) != -1) {
			message.innerHTML = "<b>아이디가 존재합니다.</b>";
		} else {
			message.innerHTML = "<b>사용할수 있는 아이디입니다.</b> <br/><input type='button' class='btn checkBtn' value='확인' onclick='insertId(\""
					+ id + "\")'>";
		}

	}
	function insertId(id) {
		opener.document.getElementById("opt_id").value = id;
		opener.document.getElementById("opt_pw").focus();
		close();
	}
</script>
</head>
<body>
	<table onchange="IDvalid()">
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id_check" id="id_check" /></td>
		</tr>
		<tr align="center" id="check_area">
			<td colspan="2">
				<input type="button" value="중복확인" class="btn checkBtn" onclick="cofirmChk()" /> 
				<input type="button" value="취소" class="btn" onclick="self.close()" />
			</td>
		</tr>
		<tr align="center">
			<td colspan="2" id="checkMessage">
			
			</td>
		</tr>
	</table>
</body>
</html>