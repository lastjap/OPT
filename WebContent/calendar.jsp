<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<script type="text/javascript" src="js/jquery.js"></script>
<link href="css/fullcalender/fullcalendar.css" rel="stylesheet" />
<link href="css/fullcalender/fullcalendar.print.css" rel="stylesheet" media="print" />
<link href="css/fullcalender/scheduler.css" rel="stylesheet" />
<link href="css/calendar.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script>

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
  function calpopup(){
	cw = screen.availWidth;
	ch = screen.availHeight;
		
	sw=500;    //띄울 창의 넓이
	sh=300;    //띄울 창의 높이

	ml = (cw - sw) / 2;
	mt = (ch - sh) / 2;

	var url = encodeURI("calendar_popup.jsp");
	window.open(url, '일정등록', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);
  }
  
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
</script>
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>
	
	
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
	<div class="cal_header">
	<h3>일정관리</h3>
	<div class="insert_btn_area">
	<button class="snip1535" onclick="calpopup();">일정등록</button>
	</div>
	</div>
  <div id='calendar'></div>
	
	<div class="footer_areawrap">
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>


<script type="text/javascript" src="js/fullcalender/moment.min.js"></script>
<script type="text/javascript" src="js/fullcalender/fullcalendar.min.js"></script>
<script type="text/javascript" src="js/fullcalender/scheduler.min.js"></script>
<script type="text/javascript" src="js/fullcalender/calendar.js"></script>
</html>