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
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title></title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function allChk(bool) {
		if (bool == true) {
			$("input[name=chk]").prop("checked", true);
		} else {
			$("input[name=chk]").prop("checked", false);
		}
	}
	$(function() {
		$("input[name=chk]")
				.click(
						function() {
							if ($("input[name=chk]:checked").length == $("input[name=chk]").length) {
								$("input[name=all]").prop("checked", true);
							} else {
								$("input[name=all]").prop("checked", false);
							}
						});
	});

	$(function() {
		$("#muldelform").submit(function() {
			if ($("#muldelform input:checked").length == 0) {
				alert("하나 이상 체크해 주세요!!");
				return false;
			}
		});
	});
</script>
<style type="text/css">
.pageHeader {
	text-align: center
}

.videoSearch {
	margin-left: 32%;
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
}

.searchBar {
	border: none;
	margin-top: 20px;
	margin-bottom: 20px;
	cursor: pointer;
}

.videofile {
	padding-bottom: 15px;
}

.deleteBtn {
	height: 36px;
	width: 85px;
	background: rgb(105, 1, 143);
	color: white;
	font-weight: bold;
	position: absolute;
	top: 199px;
    left: 68.2%;
	cursor: pointer;
}

.videolistbar {
	padding-left: 50px;
}

.paging {
	width: 320px;
    margin: 0 auto;
    height: 300px;
    /* margin-top: 40px; */
    position: relative;
    top: 120px;
    padding-left: 250px;
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
.chkbox_td{
	text-align: center;
}

.foot_area_wrap{
	position: relative;
    top: 55px;
}

</style>

</head>
<body>
	<div>
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<h1 class="pageHeader">나의 동영상 게시판</h1>
	<form class="videoSearch" action="video.do">
		<input type="hidden" name="command" value="searchVideo" /> <input
			type="hidden" name="page" value="1" />
		<table class="searchBar">
			<tr>
				<td><select class="searchoption" name="searchoption">
						<option value="video_title">제목</option>
						<option value="video_content">내용</option>
				</select></td>
				<td><input class="searchtext" type="text" name="searchtext">
					<input class="searchBtn" type="submit" value="검색하기"> <input
					class="searchBtn" type="button" value="업로드"
					onclick="location.href='videoupload.jsp'"> <input
					class="searchBtn" type="button" value="목록"
					onclick="location.href='video.do?command=videoList&page=1&videoarea=main'"></td>
			</tr>
		</table>
	</form>
	<form class="videoList" action="video.do" method="get" id="muldelform">
		<input type="hidden" name="command" value="multiDel" />
		<table>
			<colgroup>
				<col width="100">
				<col width="426">
				<col width="100">
				<col width="">
			</colgroup>
			<tr class="videolistbar">
				<th><input type="checkbox" name="all"
					onclick="allChk(this.checked);" /></th>
				<th><b>비디오</b></th>
				<th><b>내용</b></th>
				<td><input class="deleteBtn" type="submit" value="전체삭제"></td>
			</tr>
			<c:choose>
				<c:when test="${empty list }">
						<tr><td colspan="4">------등록된 상품이 없습니다------</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list }" var="videoDto">
						<c:if test="${videoDto.opt_no_seq == memdto.opt_no_seq }">
							<tr>
								<td class="chkbox_td"><input type="checkbox" name="chk"
									value="${videoDto.video_no_seq }" /></td>
								<c:set var="videourl" value="${videoDto.video_url }" />
								<td><c:choose>
										<c:when test="${fn:startsWith(videourl, 'h')}">
											<iframe width="426" height="245" src="${videoDto.video_url }"></iframe>
										</c:when>
										<c:otherwise>
											<video width="426" height="245"
												src="./video/${videoDto.video_url }" autoplay=""
												controls="controls"></video>
										</c:otherwise>
									</c:choose></td>
								<td class="videoContent"><h4 class="videotitle"
										onclick="location.href='video.do?command=videoDetail&videoseq=${videoDto.video_no_seq}&page=${page }'">${videoDto.video_title }</h4>
									조회수 : ${videoDto.video_views_no }<br /> 등록시간 : <fmt:formatDate
										value="${videoDto.video_regdate }" pattern="yyyy-MM-dd HH:mm" /><br />
									${videoDto.video_content } <br> <input class="searchBtn"
									type="button" value="수정"
									onclick="location.href='video.do?command=updatevideo&videoseq=${videoDto.video_no_seq }'">
									<input class="searchBtn" type="button" value="삭제"
									onclick="location.href='video.do?command=deletevideo&videoseq=${videoDto.video_no_seq }'">
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</form>

	<div class="paging">
		<ul class="paging_ul">
			<c:set var="prevPage" value="${absolutePage-blockCount}"></c:set>
			<c:choose>
				<c:when test="${prevPage >0}">
					<li><a
						href="video.do?command=videoList&page=${prevPage }&videoarea=my">◀</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="video.do?command=videoList&page=1&videoarea=my">◀</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${absolutePage }" end="${endPage }" var="i">
				<c:choose>
					<c:when test="${i eq page}">
						<li><a
							href="video.do?command=videoList&page=${i}&videoarea=my">${ i }</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="video.do?command=videoList&page=${i}&videoarea=my">${ i }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:set var="nextPage" value="${absolutePage+blockCount }"></c:set>
			<c:choose>
				<c:when test="${nextPage < totalPage}">
					<li><a
						href="video.do?command=videoList&page=${nextPage }&videoarea=my">▶</a></li>
				</c:when>
				<c:otherwise>
					<li><a
						href="video.do?command=videoList&page=${totalPage}&videoarea=my">▶</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<div class="foot_area_wrap">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>

</html>