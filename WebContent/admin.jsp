<%@page import="com.opt.biz.OPTBizImpl"%>
<%@page import="com.opt.biz.OPTBiz"%>
<%@page import="com.opt.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/admin.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="js/admin.js"></script>
</head>
<body>
	<!-- 관리자로 로그인 해야만 접근 가능 -->
	<c:if test="${memdto.opt_role ne 'admin'}">
		<script type="text/javascript">
			alert("잘못된 접근입니다.");
			document.location.href = "index.jsp";
		</script>
	</c:if>
	<div>
		<jsp:include page="header.jsp"/>
	</div>
	<div class="page_title">관리자님, 어서오세요</div>
	<hr style="width: 68%;">
	<div class="nav">
		<ul>
			<li class="nav_title">
				Menu
				<ul class="nav_list">
					<li><a href="#" class="adminUserManager">유저관리</a></li>
					<li><a href="#" class="adminItemManager">상품관리</a></li>
					<li><a href="#" class="adminAnswer">고객센터 관리</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="layer" style="display: none;"></div>
	<div class="main">
		<div class="main_image" style="background-image: url('image/delivery.png');"></div>
		<div class="first">
			<p>판매실적/판매현황</p>
			<hr>
			<svg style="width: 120px; height: 120px; margin-left: -15px;">
				<circle cx="60" cy="60" r="60" fill="#fddddd" />
				<text x="25" y="60" style="fill: #64736e; font-weight: bold; font-size: 24px;">배송중</text>
				<text x="47" y="85" style="fill: #7c9e76; font-weight: bold;">9건</text>
			</svg>
			<svg style="width: 120px; height: 120px; margin-left: 15px;">
				<circle cx="60" cy="60" r="60" fill="#fff7d5" />
				<text x="15" y="60" style="fill: #64736e; font-weight: bold; font-size: 24px;">주문신청</text>
				<text x="47" y="85" style="fill: #7c9e76; font-weight: bold;">14건</text>
			</svg>
			<svg style="width: 120px; height: 120px; margin-left: 15px;">
				<circle cx="60" cy="60" r="60" fill="#ffdbf6" />
				<text x="15" y="60" style="fill: #64736e; font-weight: bold; font-size: 24px;">환불요청</text>
				<text x="47" y="85" style="fill: #7c9e76; font-weight: bold;">3건</text>
			</svg>
		</div>
		<div class="graph">
			<p>판매차트<p>
			<hr>
			<script src="http://d3js.org/d3.v3.min.js"></script>
			<script type="text/javascript">
				window.onload = function() {
					var monthData = [${beforeTwoMonth}, ${beforeOneMonth}, ${thisMonth}];
					var dayData = [${beforeTwoDay}, ${beforeOneDay}, ${today}];
					var day = d3.select("#day").selectAll();
					var month = d3.select("#month").selectAll();
					// 사각형 그래프 그리기 (2달전,1달전,이번달)
					month.data(monthData).enter()
					.append("rect")
					.attr("height", function(d) {
						return d*10+"px";
					})
					.attr("width", function(d) {
						return "30px";
					})
					.attr("x", function(d, i) {
						return i*35;
					})
					.attr("y", function(d, i) {
						return 100-d*10;
					})
					.attr("class", "bar");
					// 그래프 데이터 출력
					month.data(monthData).enter()
					.append("text")
					.attr("x", function(d, i) {
						return i*35+9;
					})
					.attr("y", function(d) {
						return 90;
					})
					.style("font-size", "12pt")
					.text(function(d){
						return d;
					});
					// 그래프 레이블 출력
					month.data(monthData).enter()
					.append("text")
					.attr("x", function(d, i) {
						return i*35;
					})
					.attr("y", function(d) {
						return 120;
					})
					.style("font-size", "8pt")
					.text(function(d, i) {
						return ["2달전", "1달전", "이번달"][i];
					});
					// 사각형 그래프 그리기 (2일전,1일전,오늘)
					day.data(dayData).enter()
					.append("rect")
					.attr("height",function(d) {
						return d*10+"px";
					})
					.attr("width", function(d) {
						return "30px";
					})
					.attr("x", function(d, i) {
						return i*35;
					})
					.attr("y", function(d, i) {
						return 100-d*10;
					})
					.attr("class", "bar");
					// 그래프 데이터 출력
					day.data(dayData).enter()
					.append("text")
					.attr("x", function(d, i) {
						return i*35+9;
					})
					.attr("y", function(d) {
						return 90;
					})
					.style("font-size", "12pt")
					.text(function(d){
						return d;
					});
					// 그래프 레이블 출력
					day.data(dayData).enter()
					.append("text")
					.attr("x", function(d, i) {
						return i*35;
					})
					.attr("y", function(d) {
						return 120;
					})
					.style("font-size", "8pt")
					.text(function(d, i){
						return ["2일전", "1일전", "오늘"][i];
					});
				}
				</script>
				<svg id="day" style="width:110; height:125; margin-right: 130px; margin-left: 160px;"></svg>
				<svg id="month" style="width:110; height:125;"></svg>
		</div>
		<div class="adminUserManagerPopup" style="display: none;"></div>
		<div class="adminItemManagerPopup" style="display: none;"></div>
	</div>
	<div>
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>