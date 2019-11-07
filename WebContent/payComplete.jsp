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
<style type="text/css">
	.foot_area_wrap{
		position: relative;
		top:55px;
	}

</style>
<link href="css/payment.css" rel="stylesheet" type="text/css">
</head>
<body>


	<div >
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	
	<div class="paymentMain">
	<h1>결제가 완료되었습니다.</h1>
	<hr>
		<h2>결제정보</h2>
		<table class="user_table">
			<col width="200px" />			
			<col width="200px" />	
			<col width="200px" />
			<col width="200px" />
			<col width="200px" />
			<tr>
				<td>주문금액</td>
				<td style="text-align: right;"><fmt:formatNumber value="${itemDto.item_price * ea}" pattern="#,##0"/>원</td>
			</tr>			
			<tr>
				<td>쿠폰할인</td>
				<td style="text-align: right;">-<fmt:formatNumber value="${coupon_sale }" pattern="#,##0"/>원</td>		
			</tr>
			<tr>
				<td>포인트할인</td>
				<td style="text-align: right;">-<fmt:formatNumber value="${point }" pattern="#,##0"/>원</td>		
			</tr>
			<tr>
				<td>배송비</td>
				<td style="text-align: right;">2,500원</td>
			</tr>
			<tr>
				<td>총 결제금액</td>
				<td style="text-align: right;"><fmt:formatNumber value="${totalPrice }" pattern="#,##0"/>원</td>
			</tr>
		</table>
		<br>
	<hr>
		<h2>받는사람 정보</h2>
		<table class="user_table">
			<col width="200px" />
			<tr>
				<td>받는사람</td>
				<td>${memdto.opt_name }</td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>${memdto.opt_phone }</td>				
			</tr>
			<tr>
				<td>받는주소</td>
				<td>${addr }</td>				
			</tr>
			<tr>
				<td>요청사항</td>
				<td>${memo }</td>
			</tr>
		</table>
	<hr>
	<br>
	<input type="button" value="쇼핑 계속하기"  class="paymentBtn" onclick="location.href='item.do?command=itemlist&page=1'"/>&nbsp; 
	<input type="button" value="주문 상세보기" class="paymentBtn" onclick="location.href='opt.do?command=mypage'"/>
	</div>

	<div class="foot_area_wrap">
	<%@ include file="./footer.jsp" %>	
	</div>

</body>
</html>