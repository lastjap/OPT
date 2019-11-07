<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/basket.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">

	function closeNav() {
		document.getElementById('mysidenav').style.width = '0';
	}
	




function allChk(bool){
	//$("selector").each();
	$("input[name=chk]").each(function(i){
		$(this).prop("checked",bool);
	
	});
}

	function muldel(){
		if($("#multiDelForm input:checked").length == 0){
			alert("하나 이상 체크해 주세요!!");
			return false;
		}else{
			
			myform.action="basket.do?command=basketmuldel"
			myform.submit();
		}
		
	}
		
	
	function basketPayment(){
		
		if($("#multiDelForm input:checked").length == 0){
			alert("하나 이상 체크해 주세요!!");
			return false;
		}else{			
			
			var arr = new Array();
			
			for(var i=0; i < $("input[name=chk]:checked").length; i++ ){			
				
				arr.push($("input[name=chk]:checked").eq(i).parent().siblings().eq(2).children().val());
			
			}
			
			
			myform.action="item.do?command=basketpayment&countarr="+arr;
			myform.submit();
		}
	}
	
	
	
	function addComma(num) {
		  var regexp = /\B(?=(\d{3})+(?!\d))/g;
		  return num.toString().replace(regexp, ',');
		}
	


	$(function(){
		$('.ea').change(function(){
			
			if($(this).val() <= 0){
				alert("수량을 1개이상 입력해주세요");
				$(this).val(1);
			}else if($(this).val() > 100){
				alert("최대 수량은 100개 입니다");
				$(this).val(100);
			}				
			
			$(this).parent().siblings().eq(3).children().html(addComma($('.price').val() * $(this).val())+"원");
			
		});
		
		
		$(".line-wrapper").click(function(){
			
			if($("#mysidenav").hasClass('abc') == true) {
			
				$("#mysidenav").removeClass('abc');
				$("#mysidenav").width('0px');
			} else {
			$("#mysidenav").addClass('abc');
			$("#mysidenav").width('250px');
			}
		});
		
	});

	function coupon_popup(){
		cw = screen.availWidth;
		ch = screen.availHeight;
			
		sw=1024;    //띄울 창의 넓이
		sh=550;    //띄울 창의 높이

		ml = (cw - sw) / 2;
		mt = (ch - sh) / 2;

		var url = encodeURI("coupon.do?command=couponlist&page=1");
		window.open(url, '내쿠폰함', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);
	  }



	</script>
</head>
<body>

	<div>
	<jsp:include page="header.jsp"></jsp:include>
	</div>
	
	
	<div class="page_title">
	<h2>장바구니</h2>
	</div>
		<!-- side menu -->
	<nav class="side_menu_nav">
	<div id="mysidenav" class="sidenav">
		<div style="width : 250px;">
		<a href="#" class="closebtn" onclick='closeNav()'>x</a>
		<a href="deliver_search.jsp">운송장번호 조회</a>
		<a href="postbox.do?command=recivePostbox&page=1">마이쪽지함</a>
		<a href="calendar.jsp">일정관리</a>
		<a href="basket.do?command=basketlist">장바구니</a>
		<a onclick="coupon_popup();" style="cursor: pointer;">내쿠폰함</a>
		<a href="service.do?command=faqlist&page=1">고객센터</a>		
		</div>
	</div>
	<div class="openmenu_btn">
	</div>
	</nav>
	<!-- 햄버거 -->
		<div class="wrapper">
  <!-- 추가된 부분 -->
		  <div class="line-wrapper">
		    <div class="line"></div>
		    <div class="line"></div>
		    <div class="line"></div>
		  </div>
		</div>
		<!-- ************ -->	
	<div class="basketContent">
	<form action="basket.do" method="post" name="myform" id="multiDelForm" onsubmit="return false;">

		<table class="basketTable">

			<tr>
				<th width="50"><input type="checkbox" name="all" onclick="allChk(this.checked);"></th>				
				<th width="200">상품이미지</th>
				<th width="200">상품명</th>
				<th width="50">수량</th>
				<th width="200">상품금액</th>
			</tr>
			<tr></tr>

			<c:choose>
				<c:when test="${empty basketList}">
					<tr>
						<td colspan="6" style="text-align: center;">장바구니가 비어있습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${basketList }" var="dto">
					
					<input type="hidden" value="${dto.basket_item_no }" name="no">
					<input type="hidden" class="price" value="${dto.basket_item_price }" />
						<tr>
							<td><input type="checkbox" onclick="" name="chk"
								value="${dto.basket_no_seq }"></td>							
							<td><a href="item.do?command=itemdetail&no=${dto.basket_item_no }&page=1"><img
									alt="" src="${dto.basket_item_url }" width="150" height="150" ></a></td>							<td>${dto.basket_item_name }</td>
							<td><input type="number" style="width: 40px" id="ea" class="ea"
								value="${dto.basket_item_count }"  min="1" max="100" onkeydown="javascript: return event.keyCode == 110 ? false : true"></td>
							<td><strong id="totalPrice" class="totalPrice"><fmt:formatNumber value="${dto.basket_item_price * dto.basket_item_count }" pattern="#,##0" />원</strong></td>
						</tr>
						<tr></tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>		
		<div class="basketBtn">
		<input type="button" class="btn" value="구매하기" id="payment" onclick="basketPayment();" />
		<input type="button" class="btn" value="삭제하기" id="delete" onclick="muldel();" />
		<input type="button" value="상품목록" class="btn" id="List" onclick="location.href='item.do?command=itemlist&page=1'" />
		</div>
	</form>
	</div>



	<div class="footer_areawrap">
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
	
</body>
</html>