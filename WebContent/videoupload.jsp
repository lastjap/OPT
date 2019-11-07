<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
												"<input type='text' name='video_url' required='required'>");
								$("#videoFrm").attr({
									method : "GET",
									enctype : ""
								});
							}
						})
		$("body").on("change", "input[name=video_url]", function() {
			var url = $("input[name=video_url]").val();
			$("iframe").prop("src", url);
		});

	})
</script>
<style type="text/css">
.uploadHead {
	text-align: center;
	font-size: 2em;
	color: blueviolet;
}

.videoupload {
	left: 38%;
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
	<form id="videoFrm" action="video.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="command" value="videoupload"> <input
			type="hidden" name="videoarea" value="main"> <input
			type="hidden" name="opt_no_seq" value="${ memdto.opt_no_seq}">
		<h3 class="uploadHead">
			<b>${ memdto.opt_id}</b>님 비디오등록사이트입니다.
		</h3>
		<table class="videoupload">
			<tr class="uploadrow">
				<th>동영상 타입</th>
				<td><input name="type" type="radio" value="유튜브">유튜브 <input
					name="type" type="radio" value="개인동영상" />개인동영상
				<td>
			</tr>
			<tr class="uploadrow">
				<th>동영상 파일</th>
				<td id="videotype"></td>

			</tr>
			<tr class="uploadrow">
				<th>동영상 미리보기</th>
				<td><iframe></iframe></td>

			</tr>
			<tr class="uploadrow">
				<th>동영상 제목</th>
				<td><input type="text" name="video_title" required="required"></td>
			</tr>
			<tr class="uploadrow">
				<th>동영상 내용</th>
				<td><textarea name="video_content" required="required"
						rows="10" cols="25"></textarea></td>
			</tr>
			<tr class="uploadrow">
				<td></td>
				<td><input class="uploadBtn" type="submit" value="비디오 등록" /> <input
					class="uploadBtn" type="reset" value="리셋" /></td>
			</tr>

		</table>
	</form>

	<div class="foot_area_wrap">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>