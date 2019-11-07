<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/postSend.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	function commenMessageFn() {
		$("#messageFrm").submit();
		self.close();

	}
	
	function roundTable(objID) {
		   var obj = document.getElementById(objID);
		   var Parent, objTmp, Table, TBody, TR, TD;
		   var bdcolor, bgcolor, Space;
		   var trIDX, tdIDX, MAX;
		   var styleWidth, styleHeight;

		   Parent = obj.parentNode;
		   objTmp = document.createElement('SPAN');
		   Parent.insertBefore(objTmp, obj);
		   Parent.removeChild(obj);

		   bdcolor = obj.getAttribute('rborder');
		   bgcolor = obj.getAttribute('rbgcolor');
		   radius = parseInt(obj.getAttribute('radius'));
		   if (radius == null || radius < 1) radius = 1;
		   else if (radius > 6) radius = 6;

		   MAX = radius * 2 + 1;

		   Table = document.createElement('TABLE');
		   TBody = document.createElement('TBODY');

		   Table.cellSpacing = 0;
		   Table.cellPadding = 0;

		   for (trIDX=0; trIDX < MAX; trIDX++) {
				  TR = document.createElement('TR');
				  Space = Math.abs(trIDX - parseInt(radius));
				  for (tdIDX=0; tdIDX < MAX; tdIDX++) {
						 TD = document.createElement('TD');
						 
						 styleWidth = '1px'; styleHeight = '1px';
						 if (tdIDX == 0 || tdIDX == MAX - 1) styleHeight = null;
						 else if (trIDX == 0 || trIDX == MAX - 1) styleWidth = null;
						 else if (radius > 2) {
								if (Math.abs(tdIDX - radius) == 1) styleWidth = '2px';
								if (Math.abs(trIDX - radius) == 1) styleHeight = '2px';
						 }

						 if (styleWidth != null) TD.style.width = styleWidth;
						 if (styleHeight != null) TD.style.height = styleHeight;

						 if (Space == tdIDX || Space == MAX - tdIDX - 1) TD.style.backgroundColor = bdcolor;
						 else if (tdIDX > Space && Space < MAX - tdIDX - 1)  TD.style.backgroundColor = bgcolor;
						 
						 if (Space == 0 && tdIDX == radius) TD.appendChild(obj);
						 TR.appendChild(TD);
				  }
				  TBody.appendChild(TR);
		   }
		   Table.appendChild(TBody);
		   Parent.insertBefore(Table, objTmp);
		}
	
	
</script>
</head>
<body>
	<h1>쪽지 보내기</h1>
	<hr>
	<form id="messageFrm" action="postbox.do" method="post">
		<input type="hidden" name="command" value="sendPostRes" />
		<table id="ta1" radius="6" rborder="#999999" rbgcolor="#F8F8F8">
			<tr>
				<th>아 이 디</th>
				<td class="sendPostTd"><input type="text" name="user" value="${param.id }"
					readonly="readonly" required="required"/></td>
			</tr>
			<tr>
				<th>제 목</th>
				<td class="sendPostTd"><input type="text" name="title" required="required"
					maxlength="20" /></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td class="sendPostTd"><textarea rows="10" cols="60" name="content"
						required="required" maxlength="200" style="resize: none;"></textarea></td>
			</tr>
		</table>
		<br /> 
		<div class="sendVideoBtnDiv">
		<input id="commenMessage" type="button" class="sendPostBtn" value="쪽지보내기"
			onclick="commenMessageFn()" />&nbsp; <input type="button" class="sendPostBtn"
			value="목록으로" onclick="self.close();">
		</div>
	</form>
	
	<script>roundTable("ta1");</script>
</body>
</html>