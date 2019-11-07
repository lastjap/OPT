<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">

	function DaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function (data) {
	            var fullRoadAddr = data.roadAddress;
	            var extraRoadAddr = '';
	            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	                extraRoadAddr += data.bname;
	            }
	            if (data.buildingName !== '' && data.apartment === 'Y') {
	                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data
	                    .buildingName);
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
	
	
	function insertAddr(){
		var addr = $("#postcode").val() + " " + $("#roadAddress").val() + " " + $("#detailAddr").val();
		opener.document.getElementById("addr").innerHTML = addr;
		opener.document.getElementById("addrForm").value = addr;
		close();
	}


</script>
</head>
<body>
	<h1>배송지 변경</h1>
	<hr/>
	<input type="text" id="postcode" name="postcode"placeholder="우편번호" readonly="readonly">
	<input type="button" value="우편번호 찾기" onclick="DaumPostcode()" >
	<br/>
	<input type="text" id="roadAddress" name="roadAddress"placeholder="도로명주소" readonly="readonly" size="35"/>
	<br/>
	<input type="text" id="detailAddr" value="" placeholder="상세 주소를 입력해주세요" size="35"/>
	<br/>
	<input type="button" value="배송지 변경" onclick="insertAddr();"/>
	

</body>
</html>