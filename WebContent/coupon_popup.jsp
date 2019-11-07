<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/coupon_popup.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
</head>
<body>
	<div class="coupon_title">
	<h3>내 쿠폰함</h3>
	</div>
	<div class="coupon_list">
			<table summary="쿠폰번호 쿠폰이름 쿠폰내용 유효기간 할인가격">
				<colgroup>
					<col width="80">
					<col width="180">
					<col width="*">
					<col width="180">
					<col width="80">
				</colgroup>
				<thead>
					<tr>
						<th>
							<div class="th_title">쿠폰번호</div>
						</th>
						<th>
							<div class="th_title">쿠폰이름</div>
						</th>
						<th>
							<div class="th_title">쿠폰내용</div>
						</th>
						<th>
							<div class="th_title">유효기간</div>
						</th>
						<th>
							<div class="th_title">할인가격</div>
						</th>
					</tr>
				</thead>
	 			<tbody>
		<c:choose>
		<c:when test="${empty coupondto }">
			<tr>
				<td colspan="5">----------------내용이없습니다-------</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${coupondto }" var="dto">
					<tr>
						<td><div class="td_content">${dto.coupon_no }</div></td>
						<td><div class="td_content">${dto.coupon_name }</div></td>					
						<td><div class="td_content">${dto.coupon_content }</div></td>
						<td><div class="td_content">${dto.coupon_date }</div></td>
						<td><div class="td_content"><fmt:formatNumber value="${dto.coupon_sale }" pattern="#,##0" />원</div></td>
					</tr>
			</c:forEach>
			</c:otherwise>
		</c:choose>			
		</tbody>	 
			</table>
		</div>
		<div class="paging">
			<ul>
			<c:set var="prevPage" value="${absolutePage-blockCount}"></c:set>
			<c:choose>
				<c:when test="${prevPage >0}">
					<li><a href="coupon.do?command=couponlist&page=${prevPage }">◀</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="coupon.do?command=couponlist&page=1">◀</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${absolutePage }" end="${endPage }" var="i">
				<c:choose>
				<c:when test="${i eq page}">
					<li><a href="coupon.do?command=couponlist&page=${i}">${ i }</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="coupon.do?command=couponlist&page=${i}">${ i }</a></li>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:set var="nextPage" value="${absolutePage+blockCount }"></c:set>
			<c:choose>
				<c:when test="${nextPage < totalPage}">
					<li><a href="coupon.do?command=couponlist&page=${nextPage }">▶</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="coupon.do?command=couponlist&page=${totalPage}">▶</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
</body>
</html>