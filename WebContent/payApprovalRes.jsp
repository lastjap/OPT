<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title>결제 완료</title>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">

	function payComplete() {
		opener.location.replace("payComplete.jsp");
		self.close();
	}
	
	onload = function() {
		payComplete();
	}
</script>
</head>
<body>
</body>
</html>