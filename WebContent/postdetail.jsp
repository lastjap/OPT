<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/postSend.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">

	function closeNav() {
		document.getElementById('mysidenav').style.width = '0';
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
	

	$(document).ready(function(){
	
		$(".line-wrapper").click(function(){
			
			if($("#mysidenav").hasClass('abc') == true) {
			
				$("#mysidenav").removeClass('abc');
				$("#mysidenav").width('0px');
			} else {
				$("#mysidenav").addClass('abc');
				$("#mysidenav").width('250px');
			}
		});
		
		
		
	});


</script>
</head>
<body>
	
	<div>
	<jsp:include page="header.jsp"></jsp:include>
	</div>
	
	<div class="page_title">
		<h2>쪽지 보내기</h2>
	</div>
		<!-- side menu -->
	<nav class="side_menu_nav">
	<div id="mysidenav" class="sidenav">
		<div style="width : 250px;">
		<a href="#" class="closebtn" onclick='closeNav()'>x</a>
		<a href="deliver_search.jsp">운송장번호 조회</a>
		<a href="postbox.do?command=recivePostbox&page=1">마이쪽지함</a>
		<a href="calendar.jsp">일정관리</a>
		<a href="basket.do?command=basketlist">장바구니</a>
		<a onclick="coupon_popup();" style="cursor: pointer;">내쿠폰함</a>
		<a href="#">고객센터</a>		
		</div>
	</div>
	<div class="openmenu_btn">
	</div>
	</nav>
	<!-- 햄버거 -->
		<div class="wrapper">
  <!-- 추가된 부분 -->
		  <div class="line-wrapper">
		    <div class="line"></div>
		    <div class="line"></div>
		    <div class="line"></div>
		  </div>
		</div>
		<!-- ************ -->
	<div class="postSend">
	<table id="ta1" radius="6" rborder="#999999" rbgcolor="#F8F8F8">		
		<tr>
			<th>보낸사람 </th>
			<td class="postDetailTd">${postDto.opt_id }</td>	
		</tr>
		<tr>
			<th></th>
			<td></td>	
		</tr>
		<tr>
			<th>보낸시간 </th>
			<td class="postDetailTd">${postDto.post_send_date }</td>
		</tr>
		<tr>
			<th></th>
			<td></td>	
		</tr>
		<tr>
			<th>제     목 </th>
			<td class="postDetailTd">${postDto.post_title }</td>
		</tr>
		<tr>
			<th></th>
			<td></td>	
		</tr>
		<tr>
			<th>내     용 </th>
			<td class="postDetailTd"><textarea rows="10" cols="60" readonly="readonly" style="resize: none;">${postDto.post_content }</textarea></td>
		</tr>
	</table>
	<br/>
	<div class="postDetailBtnDiv">
		<input type="button" class="sendPostBtn" value="답장" onclick="location.href='postbox.do?command=sendPostForm&user=${postDto.opt_id }&type=${type }&page=${page }'" />&nbsp;
		<input type="button" class="sendPostBtn" value="쪽지목록" onclick="location.href='postbox.do?command=${type }&page=${page }'"/>&nbsp;
		<input type="button" class="sendPostBtn" value="삭제" onclick="location.href='postbox.do?command=delPost&post_no=${postDto.post_no_seq }&type=${type }&page=${page }'"/>
	</div>
	</div>

	<div class="footer_areawrap">
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<script>roundTable("ta1");</script>
	

</body>
</html>