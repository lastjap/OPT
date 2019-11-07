<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품페이지</title>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<link href="css/item_list.css" rel="stylesheet" type="text/css">
<style type="text/css">

	#myButton1{
	    cursor: pointer;
	}

</style>
<script type="text/javascript">

	function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}
	

	$(document).ready(function(){
		
		for(var i=0; i<$('.price').length; i++){
			
			$('.commaPrice').eq(i).html(addComma($('.price').eq(i).val()));
		
		}
		

	});

</script>

</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>
	
	<div class="item_search_wrap">
	<form action="item.do?command=itemsearch&page=1" method="post" name="fr">
	<div class="item_search">
			<div class="select-wrap">
				<select name="keyword" class="select-box">
				<c:if test="${keyword == 'title'}">
					<option value="title" selected="selected">상품명</option>
					<option value="content">상품내용</option>
					<option value="titleContent">상품명+상품내용</option>
				</c:if>
				<c:if test="${keyword == 'content'}">
					<option value="title">상품명</option>
					<option value="content" selected="selected">상품내용</option>
					<option value="titleContent">상품명+상품내용</option>
				</c:if>
				<c:if test="${keyword == 'titleContent'}">
					<option value="title">상품명</option>
					<option value="content">상품내용</option>
					<option value="titleContent" selected="selected">상품명+상품내용</option>
				</c:if>
				</select>
				<div class="select-point">▽</div>
				<input type="text" name="msg" value="${msg }"/>
				<div class="search_item" onclick="submit();">
				<img id="myButton1" alt="" src="./deliver_img/icon_sch_big.png">
				</div>
			</div>	
	</div>			
	</form>
	</div>
	
	<script type="text/javascript">
	function submit(){
		document.fr.submit();
	}
	
	</script>
	
	<div class="item_list_wrap">
	
		<c:choose>
			<c:when test="${empty list }">				
						<div>------등록된 상품이 없습니다------</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list}" var="dto">
							<div class="item_list_div">	
								<div class="item_list">
									<a href="item.do?command=itemdetail&no=${dto.item_num_seq}&page=${page}">
									<img alt="" src="${dto.item_url}" width="270px" height="270px"/></a>
								
								<div class="item_text">
									<input type="hidden" class="price" value="${dto.item_price }"/>
									<h3>${dto.item_name }</h3>																		
									<strong class="commaPrice"></strong>원<br/>
									<a>view : ${dto.item_views_no }</a>									
								</div>
								</div>
							</div>	
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="paging">
		<ul class="paging_ul">
			<c:set var="prevPage" value="${absolutePage-blockCount}"></c:set>
			<c:choose>
				<c:when test="${prevPage >0}">
					<li><a href="item.do?command=itemsearch&page=${prevPage }&keyword=${keyword }&msg=${msg }">◀</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="item.do?command=itemsearch&page=1&keyword=${keyword }&msg=${msg }">◀</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${absolutePage }" end="${endPage }" var="i">
				<c:choose>
				<c:when test="${i eq page}">
					<li><a href="item.do?command=itemsearch&page=${i}&keyword=${keyword }&msg=${msg }">${ i }</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="item.do?command=itemsearch&page=${i}&keyword=${keyword }&msg=${msg }">${ i }</a></li>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:set var="nextPage" value="${absolutePage+blockCount }"></c:set>
			<c:choose>
				<c:when test="${nextPage < totalPage}">
					<li><a href="item.do?command=itemsearch&page=${nextPage }&keyword=${keyword }&msg=${msg }">▶</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="item.do?command=itemsearch&page=${totalPage}&keyword=${keyword }&msg=${msg }">▶</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>	
	
	
	
	
	
	<%@ include file="./footer.jsp" %>

</body>
</html>