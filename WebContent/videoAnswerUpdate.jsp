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
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<style type="text/css">

.updatebtn{
background-color: purple;
	font-family: 'Nanum Gothic', sans-serif;
width: 50px;
height: 30px;
color: white;
border-color: yellow;
}

.opt_id{
width: 50px;
height: 20px;
font-weight: bold;

}
.video_reple{
width: 500px;
height: 100px;


}


</style>
</head>
<body>
	<form action="video.do" method="get">
		<input type="hidden" name="command" value="videoAnswerUpdateres">
		<input type="hidden" name="videoseq" value="${videoseq }"> <input
			type="hidden" name="video_comment_seq"
			value="${videoComment.video_comment_seq }">
		<table >
			
			<tr>
				<td><input class="opt_id" name="opt_id" value="${videoComment.opt_id }" readonly="readonly" /></td>
				</tr>
				<tr>
				<td><textarea rows="30" cols="10" wrap="hard" class="video_reple"
							name="video_reple">${videoComment.video_reple }</textarea>
				
				</td>
					</tr>
					<tr>
				<td>   <fmt:formatDate
									value="${videoComment.video_comment_date }"
									pattern="yy-MM-dd HH:mm" /></td>
			</tr>
		</table>
		<input type="submit" value="변경" onclick="window.close();" class="updatebtn" >
	</form>
</body>
</html>