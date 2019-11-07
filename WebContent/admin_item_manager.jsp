<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<link href="css/admin_item_manager.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<div class="item_title">
	상품관리<br>
	<span class="item_title_mini">
		관리할 상품을 선택하세요
	</span>
</div>
<a href="#" class="itemManagerPopupClose">x</a>
<table class="item_list">
	<tr>
		<th><input type="checkbox" name="itemAllChk"></th>
		<th>상품번호</th>
		<th>상품이름</th>
		<th>가격</th>
		<th>상품설명</th>
		<th>판매상태</th>
		<th></th>
	</tr>
	<c:forEach items="${itemList}" var="ItemDto">
		<tr>
			<td><input type="checkbox" name="itemChk"></td>
			<td>${ItemDto.item_num_seq}</td>
			<td>${ItemDto.item_name}</td>
			<td>${ItemDto.item_price}</td>
			<td>${ItemDto.item_content}</td>
			<td>
				<c:choose>
					<c:when test="${ItemDto.item_enabled eq 'Y'}">
						<c:out value="판매중"/>
					</c:when>
					<c:otherwise>
						<c:out value="판매중지"/>
					</c:otherwise>
				</c:choose>
			</td>
			<td><input type="button" class="itemUpdate" value="수정"></td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="7">
			<input type="button" class="itemUnDelete" value="판매시작하기">
			<input type="button" class="itemDelete" value="판매중지하기">
		</td>
	</tr>
</table>
<div class="itemPageNum">
	<c:forEach var="i" begin="${startPage}" end="${endPage}">
		<a href="#" class="itemPage"><c:out value="${i}"/></a>
		&nbsp;
	</c:forEach>
</div>















