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
<title>bootstrap4</title>
<style type="text/css">
	.foot_wrap_area{
		position: relative;
		top:55px;
	}
	.editer_wrap{
	    margin-left: 275px;
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
<link href="css/customerwrite.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>
	<div class="content_wrap">
	<h3>글 작성</h3>
	<div class="editer_wrap">
	<form action="service.do" method="get" role="form" novalidate onsubmit="postForm()">
		<input type="hidden" name="command" value="insertres" /> <input
			type="hidden" name="opt_no_seq" value="${ memdto.opt_no_seq}" />
		<table>
			<tr>
				<th>작성자</th>
				<td><input type="text" value="${ memdto.opt_id}" readonly="readonly"></td>
			</tr>
			<tr>
				<th>제 목</th>
				<td><input type="text" name="customer_title" placeholder="" required="required"></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea name="customer_content" style="display: none;" required="required"></textarea>
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
			$('textarea[name="customer_content"]').val(
					$('#summernote').summernote('code'));
		}
	</script>
	<div class="foot_wrap_area">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>