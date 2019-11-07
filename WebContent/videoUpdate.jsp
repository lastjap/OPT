<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비디오 업데이트 하자</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<script>
	$(function() {
		$("input[type=radio]")
				.click(
						function() {
							var filetype = $(this).val();
							if (filetype == "개인동영상") {
								$("#videotype")
										.html(
												"<input type='file' name='video_url' required='required'>");
								$("#videoFrm").attr({
									method : "post",
									enctype : "multipart/form-data"
								});
							} else if (filetype == "유튜브") {
								$("#videotype")
										.html(
												"<input type='text' name='video_url' required='required' size='55'>");
								$("#videoFrm").attr({
									method : "GET",
									enctype : ""
								});

							} else if (filetype == "현재동영상") {
								$("#videotype")
										.html(
												"<input type='text' name='video_url' required='required' value='${videoDto.video_url}' size='55'>");
								$("#videoFrm").attr({
									method : "GET",
									enctype : ""
								});
							}
						})

	})
</script>
<style type="text/css">
.uploadHead {
	text-align: center;
	font-size: 2em;
	color: blueviolet;
}

.videoupload {
	left: 35%;
	position: relative;
	border-spacing: 20px;
}

.uploadBtn {
	height: 36px;
	width: 85px;
	background: rgb(105, 1, 143);
	color: white;
	font-weight: bold;
	cursor: pointer;
	border-radius: 20px;
}

.uploadrow {
	font-size: 1.5em;
	text-align: left;
}

.uploadBtnrow {
	position: relative;
	left: 33%;
}
.foot_area_wrap{
	position: relative;
	top:55px;
}
</style>
</head>
<body>
	<div>
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<h1 class="uploadHead">${ memdto.opt_id}님비디오수정사이트입니다.</h1>
	<table class="videoupload">
		<col width="300">
		<tr>
			<c:set var="videourl" value="${videoDto.video_url }" />
			<td><c:choose>
					<c:when test="${fn:startsWith(videourl, 'h')}">
						<iframe width="600" height="330" src="${videoDto.video_url }"></iframe>
					</c:when>
					<c:otherwise>
						<video width="600" height="330"
							src="./video/${videoDto.video_url }" controls="controls"></video>
					</c:otherwise>
				</c:choose></td>
		</tr>
	</table>
	<form id="videoFrm" action="video.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="command" value="videoupdateres"> 
		<input	type="hidden" name="videoarea" value="main">
		<input	type="hidden" name="videoseq" value="${videoDto.video_no_seq }">
		<table class="videoupload">
			<tr class="uploadrow">
				<th>비디오 제목</th>
				<td><input type="text" name="video_title" required="required"
					value="${videoDto.video_title }" size="50"></td>
			</tr>
			<tr class="uploadrow">
				<th>비디오 내용</th>
				<td><textarea name="video_content" required="required"
						rows="10" cols="55">${videoDto.video_content }</textarea></td>
			</tr>
			<tr class="uploadrow">
				<th>비디오 파일</th>
				<td id="videotype"></td>
			</tr>
			<tr class="uploadrow">
				<th>비디오 타입</th>
				<td><input name="type" type="radio" value="유튜브" />유튜부 <input
					name="type" type="radio" value="개인동영상" />개인동영상 <input name="type"
					type="radio" value="현재동영상" /> 현재동영상
				<td>
			</tr>
			<tr class="uploadrow">
				<th>등록시간</th>
				<td><fmt:formatDate value="${videoDto.video_regdate }"
						pattern="yyyy-MM-dd" /></td>

			</tr>
			<tr>
				<td class="uploadBtnrow"><input class="uploadBtn" type="submit"
					value="비디오 수정" /> <input class="uploadBtn" type="reset" value="리셋" /></td>
			</tr>
		</table>
	</form>
	<div class="foot_area_wrap">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>