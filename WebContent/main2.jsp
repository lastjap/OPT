<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>OPT</title>
<script src='https://cdnjs.cloudflare.com/ajax/libs/lodash.js/3.10.1/lodash.min.js'></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="js/jquery.parallax.js"></script>
<link href="css/main.css" rel="stylesheet" type="text/css">

</head>
<body class="main_body">
	<header class="header">
		<div class="Menu">
			<div class ="innerMenu">
				<ul class="topmenu">
					<li>
						<a class = "menulogo" href="main3.html" title="OPT 메인으로 이동">
							<img alt="main" src="./main_image/logo.png" width=110px; height=50px;>
						</a> 
						<a class = "menulist" href="">OPT</a>
					</li>
					<li>
						<a class = "menulist" href="">PT받기</a>
						<a class = "menulist" href="item.do?command=itemlist&page=1">FOOD</a>
					</li>
					<li>
						<a class = "menulist" href="">고객지원</a>
					</li> 
					<li> 
						<a class = "menulist" href="" style = "margin-right: 0px;">
							검색
							<img alt="search" src="./main_image/button_search.png"width="25px" height="25px">
						</a>
					</li>
					<li>
						<c:out value="${memdto.opt_id}"/>
					<% if(session.getAttribute("memdto") == null) { %>
							<a class="menulist" href="login.jsp?Flag=0">로그인</a>
					<% } else {%>
							<a class="menulist" href="login.do?command=logout">로그아웃</a>
					<% } %>
					<a class="menulist" href="opt.do?command=mypage">마이페이지</a>
					</li>
				</ul>
			</div>
		</div>
	</header>
	
	<div class="bar">
		<div class="bar_inner" style="width: 100%; height: 3px; background-color: rgb(255, 255, 255); opacity: 0.2;"></div>
	</div>
	<div class="container">
		<section class="background">
			<div class="content-wrapper">
				<p class="content-title">어디서나 함께하는</p>
				<p class="content-subtitle">
					<strong>운동 친구</strong>
				</p>
			</div>
		</section>
		<section class="background">
			<div class="content-wrapper">
				<p class="content-title">철저한 </p>
				<p class="content-subtitle">
					<strong>식단 관리</strong>
				</p>
			</div>
		</section>
		<section class="background">
			<div class="content-wrapper">
				<p class="content-title">Section Three</p>
				<p class="content-subtitle">Quisque ut egestas nulla</p>
			</div>
		</section>
	</div>
</body>
</html>