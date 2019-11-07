<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품페이지</title>
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	if(${empty memdto} == true){
		$(".myvedioBtn").attr("style","display:none");
		}
})
	function videouploada(){
		var opt_no = 0 + 0${memdto.opt_no_seq };
		if(opt_no == 0){
			location.href="login.jsp?Flag=1";
		}else{
			location.href="videoupload.jsp";
		}
	}
	function videoMessage(id) {

		console.log(id);
 		window.open("videoMessage.jsp?id="+id, "", "width=600px; height=480px;");
 	}

</script>
<style type="text/css">
.pageHeader {
	text-align: center
}

.videoSearch {
	margin-left: 35%;
	margin-bottom: 30px;
}

.videoList {
	margin-left: 20%;
}

.videoContent {
	padding-left: 40px;
	position: absolute;
	width: 533px;
	height: 243px;
	overflow: hidden;
}

.videoPaging {
	margin-left: 50%
}

.searchoption {
	width: 92px;
	height: 36px;
}

.searchtext {
	width: 300px;
	height: 30px;
	font-weight: bold
}

.searchBtn {
	height: 36px;
	width: 85px;
	background: rgb(105, 1, 143);
	color: white;
	font-weight: bold;
	cursor: pointer;
}

.videotitle {
	font-size: 1.5em;
	margin-top: 1px;
	cursor: pointer;
}

.searchBar {
	border: none;
	margin-top: 20px;
	margin-bottom: 20px;
}

.videofile {
	padding-bottom: 15px;
}

.messageBtn {
	cursor: pointer;
}
.foot_area_wrap{
	position: relative;
	top: 55px;
	
}
.paging {
	width: 320px;
    margin: 0 auto;
    height: 300px;
    /* margin-top: 40px; */
    position: relative;
    top: 120px;
    padding-left: 80px;
}

.paging_ul {
	float: left;
	display: inline;
}

.paging_ul li {
	float: left;
}

.paging_ul li a {
	float: left;
	padding: 4px;
	margin-right: 3px;
	width: 21px;
	color: #000;
	font: bold 12px tahoma;
	border: 1px solid #eee;
	text-align: center;
	text-decoration: none;
}

.paging_ul li a:hover, .paging_ul li a:focus {
	color: #fff;
	border: 1px solid #f40;
	background-color: #f40;
}
</style>
</head>
<body>
	<div>
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<h1 class="pageHeader">동영상 게시판</h1>
	<form class="videoSearch" action="video.do">
		<input type="hidden" name="command" value="searchVideo" /> <input
			type="hidden" name="page" value="1" />
		<table class="searchBar">
			<tr>
				<td><select class="searchoption" name="searchoption">
						<option value="opt_id">아이디</option>
						<option value="video_title">제목</option>
						<option value="video_content">내용</option>
				</select></td>
				<td><input class="searchtext" type="text" name="searchtext">
					<input class="searchBtn" type="submit" value="검 색"></td>
				<td class="myvedioBtn"><input class="searchBtn" type="button"
					value="나의 동영상"
					onclick="location.href='video.do?command=videoList&page=1&videoarea=my'">
					<input class="searchBtn" type="button" value="업로드"
					onclick="location.href='videoupload.jsp'"></td>
			</tr>
		</table>
	</form>
	<table class="videoList">
		<c:choose>
			<c:when test="${empty list }">
						------등록된 동영상이 없습니다------
				</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="videoDto">
					<tr>
						<c:set var="videourl" value="${videoDto.video_url }" />
						<td class="videofile"><c:choose>
								<c:when test="${fn:startsWith(videourl, 'h')}">
									<iframe width="426" height="245" src=${videoDto.video_url }></iframe>
								</c:when>
								<c:otherwise>
									<video width="426" height="245"
										src="./video/${videoDto.video_url }" controls="controls"></video>
								</c:otherwise>
							</c:choose></td>
						<td class="videoContent">
							<h4 class="videotitle"
								onclick="location.href='video.do?command=videoDetail&videoseq=${videoDto.video_no_seq}&page=${page }'">${videoDto.video_title }</h4>
							<span class="messageBtn"
							onclick="videoMessage('${videoDto.opt_id}')"><b>${videoDto.opt_id}</b><i></span>
							<span>조회수 : ${videoDto.video_views_no }</span> <span> 등록시간
								: <fmt:formatDate value="${videoDto.video_regdate }"
									pattern="yyyy-MM-dd HH:mm" /><br>
						</span> <br /> ${videoDto.video_content }
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>

	<div class="paging">
		<ul class="paging_ul">
			<c:set var="prevPage" value="${absolutePage-blockCount}"></c:set>
			<c:choose>
				<c:when test="${prevPage >0}">
					<li><a
						href="video.do?command=videoList&page=${prevPage }&videoarea=main }">◀</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="video.do?command=videoList&page=1&videoarea=main">◀</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${absolutePage }" end="${endPage }" var="i">
				<c:choose>
					<c:when test="${i eq page}">
						<li><a
							href="video.do?command=videoList&page=${i}&videoarea=main">${ i }</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="video.do?command=videoList&page=${i}&videoarea=main">${ i }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:set var="nextPage" value="${absolutePage+blockCount }"></c:set>
			<c:choose>
				<c:when test="${nextPage < totalPage}">
					<li><a
						href="video.do?command=videoList&page=${nextPage }&videoarea=main">▶</a></li>
				</c:when>
				<c:otherwise>
					<li><a
						href="video.do?command=videoList&page=${totalPage}&videoarea=main">▶</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<div class="foot_area_wrap">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>

</html>