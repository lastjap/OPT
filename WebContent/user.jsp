<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	int pay_count = Integer.parseInt(request.getParameter("pay_count"));
	int coupon_count = Integer.parseInt(request.getParameter("coupon_count"));
%>
<link href="css/mypage.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>

<script type="text/javascript">

function closeNav() {
	document.getElementById('mysidenav').style.width = '0';
}

$(document).ready(function(){
/* 	$(".side_menu_nav").mouseenter(function(){
		$("#mysidenav").width('250px');
	});
	$(".side_menu_nav").mouseleave(function(){
		$("#mysidenav").width('0px');
	}); */
	
	
	
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
	function coupon_popup(){
	cw = screen.availWidth;
	ch = screen.availHeight;
		
	sw=1024;    //띄울 창의 넓이
	sh=550;    //띄울 창의 높이

	ml = (cw - sw) / 2;
	mt = (ch - sh) / 2;

	var url = encodeURI("coupon.do?command=couponlist&page=1");
	window.open(url, '내쿠폰함', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);
  }


function updateForm(){
	cw = screen.availWidth;
	ch = screen.availHeight;
		
	sw=1024;    //띄울 창의 넓이
	sh=800;    //띄울 창의 높이

	ml = (cw - sw) / 2;
	mt = (ch - sh) / 2;

	var url = encodeURI("updateUser.jsp");
	window.open(url, '회원정보수정', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);
}

</script>
</head>
<body>

	<div>
	<jsp:include page="header.jsp"></jsp:include>
	</div>
	
	<div class="page_title">
		<h2>마이페이지</h2>
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
		<a href="service.do?command=faqlist&page=1">고객센터</a>		
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
	<div class="mypage_content">
		<div class="mypage_welcome">
		<div class="welcom_box">
		<dl class="welcom_hello">
		<dt class="welcom_name">
		안녕하세요 <span>${memdto.opt_name }</span>&nbsp;님 환영합니다
		</dt>
		
		<dd>
		<p></p>
			<a class="link" onclick="updateForm()" style="cursor: pointer;">개인정보 수정</a>
			<a href="calendar.jsp" class="link">일정관리</a>
		</dd>	
		</dl>
		<div class="coupon_box">
		<dl class="coupon" style="cursor: pointer;" onclick="coupon_popup();">
			<dt>쿠폰</dt>
			<dd><b class="num"><%=coupon_count %></b> 장</dd>
		</dl>
		<dl class="opt_point" onclick="">
			<dt>포인트</dt>
			<dd><b class="num">${memdto.opt_point }</b> 포인트</dd>
		</dl>
		<dl class="opt_pay" onclick="">
			<dt>결제</dt>
			<dd><b class="num"><%=pay_count %></b> 결제건수</dd>
		</dl>
		</div>
		</div>
		
		</div>
		<div class="order_list_title">
			<h2>최근 주문 내역</h2>
		</div>
		<div class="order_list">
			<table summary="번호 주문일자 상품명 결제금액">
				<colgroup>
					<col width="70">
					<col width="100">
					<col width="*">
					<col width="100">
				</colgroup>
				<thead>
					<tr>
						<th>
							<div class="th_title">번호</div>
						</th>
						<th>
							<div class="th_title">주문일자</div>
						</th>
						<th>
							<div class="th_title">상품명</div>
						</th>
						<th>
							<div class="th_title">결제금액</div>
						</th>
					</tr>
				</thead>
				<tbody>
		<c:choose>
		<c:when test="${empty orderdto }">
			<tr>
				<td colspan="3">----------------내용이없습니다-------</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${orderdto }" var="dto">
					<tr>
						<td><div class="td_content">${dto.r }</div></td>
						<td><div class="td_content">${dto.pay_date }</div></td>					
						<td><div class="td_content">${dto.name }</div></td>
						<td><div class="td_content"><fmt:formatNumber value="${dto.pay_all }" pattern="#,##0" />원</div></td>
					</tr>
			</c:forEach>
			</c:otherwise>
		</c:choose>			
		</tbody>	
			</table>
		</div>
	</div>
	<div>
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>