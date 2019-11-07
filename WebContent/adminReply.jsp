<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">

	body,html{
	margin:0;
	padding:0;
	border:0;
	color: #888;
    font-style: normal;
}	

	.content_wrap{
		margin: 0 auto;
  	  	padding-top: 10px;
    	width: 100%;
   	 	height: 750px;
    	margin-top: 30px;
	}
	.content_wrap h3{
	text-align: center;
    font-size: 30px;
	}
	.editer_wrap{
	margin-left: 120px;
    margin-top: 40px;
	}
	.editer_wrap table tr th{
	padding: 22px 0;
    border-bottom:  1px solid #e6e6e6;
    background-color: #fff;
    font-weight: bold;
    font-size: 18px;
    text-align: center;
    width: 110px;
}

.editer_wrap table tr td{
    padding: 22px 0;
    border-bottom: 1px solid #e6e6e6;
    font-size: 18px;
}

input[type=text]{
    width: 100%;
    padding: 6px;
}

.btn_area{
    margin-top: 30px;
}

.btn {
	background-color: #cbb795;
    cursor: pointer;
    border: none;
    color: #fff;
    font-weight: 600;
}

</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css"
	rel="stylesheet">
	<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
</head>
<body>
	<div class="content_wrap">
	<h3>글 작성</h3>
	<div class="editer_wrap">
	<form action="service.do" method="get" role="form" novalidate
		onsubmit="postForm()">
		<input type="hidden" name="command" value="adminanswer" /> <input
			type="hidden" name="opt_no_seq" value="${ memdto.opt_no_seq}" />
			<input type="hidden" name="customer_no_seq" value="${param.customer_no_seq }" />
		<table>
			<tr>
				<th>작성자</th>
				<td><input type="text" value="${ memdto.opt_id}" readonly="readonly"></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea name="admin_answer_content" style="display: none;"></textarea>
					<div id="summernote"></div></td>
			</tr>
		</table>
			<div class="btn_area">				
				<input type="submit" class="btn" value="확인">
				<input type="button" class="btn" value="목록" onclick="location.href='service.do?command=servicelist&page=1'">
			</div>
	</form>
	</div>
	</div>
	<script>
		$('#summernote').summernote({
			tabsize : 1,
			height : 300
		});

		function postForm() {
			$('textarea[name="admin_answer_content"]').val(
					$('#summernote').summernote('code'));
		}
	</script>
</body>
</html>