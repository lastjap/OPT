<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
	<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
$(function(){
	if(${empty memdto }){
		$("#commentFrm").attr("style","display:none");
	}
	
})

$(function(){
	$("img").click(function(){
		$(this).next().slideToggle().end()
		.parent().siblings().find("ul").toggle();
			//$(".sub_menu2").toggle();
		});
	});

</script>
<style type="text/css">
html, body {
	margin: 0;
	padding: 0;
	border: 0;
	color: #888;
	font-style: normal;
	font-size: 16px;
	font-weight: 400;
	line-height: 1;
	letter-spacing: -1px;
	height: 100%;
}

ul, li {
	list-style: none;
	margin: 0;
	padding: 0;
}

setion {
	display: block;
}

.video_area {
	margin: 0 auto;
	padding-top: 10px;
	width: 1600px;
	padding-left: 100px;
	position: relative;
	height: 1000px;
}

a {
	text-decoration: none;
}

.side_nav_video {
	width: 500px;
    height: 1262px;
    position: absolute;
    top: 120px;
    left: 1270px;
}

hr {
	width: 1050px;
	margin-left: 0px;
}

#video_reple {
	margin: 50px;
	size: 100px;
	width: 800px;
	margin-right: 10px;
	margin-left: 10px;
	height: 20px;
}

#opt_id {
	font-weight: bold;
}

.sub_menu1 {
	cursor: pointer;
}

.sub_menu2 {
	display: none;
	cursor: default;
}

#video_submit {
	width: 60px;
	height: 30px;
	background-color: purple;
	color: white;
	border: none;
	text-align: center;
}

.answerwrite {
	padding-left: 100px;
}

.answerlist {
	padding-left: 10px;
	width: 850px;
	height: auto;
}

.content {
	font-size: 15px;
	font-family: 'Nanum Gothic', sans-serif;
}

.opt_id {
	width: 50px;
	white-space: nowrap;
	padding-right: 20px;
	font-size: 1.3em;
	color: purple;
}

.video_reple {
	width: auto;
	height: auto;
	padding-right: 20px;
	font-family: 'Nanum Gothic', sans-serif;
}

.comment_date {
	width: 120px;
	white-space: nowrap;
}

.preference {
	width: 30px;
}

.comment_one {
	height: 40px;
}

.foot_wrap {
	position: relative;
	top: 270px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="video_area">
		<div>

			<c:set var="videourl" value="${videoDto.video_url }" />
			<c:choose>
				<c:when test="${fn:startsWith(videourl, 'h')}">
					<iframe width="900" height="506" src=${videoDto.video_url }></iframe>
				</c:when>
				<c:otherwise>
					<video width="900" height="506"
						src="./video/${videoDto.video_url }" controls="controls"></video>
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<h1>${videoDto.video_title }</h1>
		</div>
		<div>
			<h3>조회수 ${videoDto.video_views_no }</h3>
		</div>
		<hr>
		<div class="content">
			<div style="width: 1050px;">${videoDto.video_content }</div>
			<br>
			<div>
				<span> 게시일 : <fmt:formatDate
						value="${videoDto.video_regdate }" pattern="yyyy-MM-dd HH:mm" /><br><br>
				</span>${videoDto.opt_id}
			</div>
			<br>
		</div>
		<hr>
		<form action="video.do" method="get" id="commentFrm">
			<input type="hidden" name="command" value="videoAnswerinsert">
			<input type="hidden" name="no" value="${videoDto.video_no_seq }">
			<table>

				<tr>
					<td style="font-weight: bold;">${memdto.opt_id }</td>
					<td><textarea rows="30" cols="10" wrap="hard" id="video_reple"
							name="video_reple"></textarea></td>
					<td><input type="submit" id="video_submit" value="댓글 "></td>
				</tr>
			</table>
		</form>

		<hr>
		<table class="answerlist">

			<c:choose>
				<c:when test="${empty list }">
						------댓글이 없습니다------
			</c:when>
				<c:otherwise>
					<c:forEach items="${list }" var="videoComment">
						<tr class="comment_one">
							<td class="opt_id"><c:out value="${videoComment.opt_id }" /></td>
							<td class="video_reple"><pre><c:out value="${videoComment.video_reple }" /></pre></td>
							<td class="comment_date"><fmt:formatDate
									value="${videoComment.video_comment_date }"
									pattern="yyyy-MM-dd HH:mm" /></td>
							<c:choose>
								<c:when test="${memdto.opt_no_seq == videoComment.opt_no_seq }">
									<td class="preference"><ul class="main_menu">


											<li class="sub_menu1"><img alt="" src="image/answer.png"
												width="30" height="30">
												<ul class="sub_menu2">
													<li><a
														href="video.do?command=DeletevideoAnswer&commentseq=${videoComment.video_comment_seq }&videoseq=${videoDto.video_no_seq}&page=1">삭제</a></li>
													<li><a
														href="video.do?command=videoAnswerUpdate&commentseq=${videoComment.video_comment_seq }&videoseq=${videoDto.video_no_seq}&page=1"
														onclick="window.open(this.href,'댓글 수정','width=700px,height=300px,top = 100, left = 200, location = no');return false;">수정</a></li>

												</ul></li>
										</ul></td>

								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>

		<div class="side_nav_video">
			<table>
				<c:choose>
					<c:when test="${empty videoList }">
						------등록된 동영상이 없습니다------
				</c:when>

					<c:otherwise>
						<c:forEach items="${videoList }" var="videoDto">
							<tr>
								<c:set var="videourl" value="${videoDto.video_url }" />
								<td><c:choose>
										<c:when test="${fn:startsWith(videourl, 'h')}">
											<iframe width="400" height="200" src=${videoDto.video_url }></iframe>
										</c:when>
										<c:otherwise>
											<video width="400" height="200"
												src="./video/${videoDto.video_url }" controls="controls"></video>
										</c:otherwise>
									</c:choose></td>
								<td style="padding-left: 20px; padding-bottom: 130px;"
									onclick="location.href='video.do?command=videoDetail&videoseq=${videoDto.video_no_seq}&page=${page }'">
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>

		</div>
	</div>
	<div class="foot_wrap">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>