<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.HttpURLConnection"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title>Insert title here</title>
<style type="text/css">
.foot_area_wrap{
	position: relative;
	top: 55px;
}

</style>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<link href="css/payment.css" rel="stylesheet" type="text/css">



<script type="text/javascript">


	function addrChange(){
		window.open("addr.jsp", "", "width=300px; height=300px;" );		
	}

	function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}
	
	
	

	$(document).ready(function(){
		
				
		var coupon = 0;
		var point = 0;
		var maxPoint = Number($("#point").attr("max"));
		var totalPrice = Number($("#totalPrice").val());
		var postPrice = Number($("#postPrice").val());
		var totalPayment = totalPrice + postPrice;
		
		$("#totalPayment").html(addComma(totalPayment) + "원");
		$("#total").val(totalPayment - coupon - point);
		

		$("#point").change(function(){
					
			if($("#point").val() > maxPoint){
				alert("보유포인트를 초과하였습니다")
				$("#point").val(maxPoint);
				point = Number($("#point").val());			
				$("#totalPayment").html(addComma(totalPayment - coupon - point) + "원");
				$("#total").val(totalPayment - coupon - point);
				$("input[name=total_amount]").val(totalPayment - coupon - point);
				$("input[name=tax_free_amount]").val(totalPayment - coupon - point);
			
			}else if($("#point").val() < 0){
				alert("숫자로만 입력해주세요!")
				$("#point").val(0);
				point = Number($("#point").val());				
				$("#totalPayment").html(addComma(totalPayment - coupon - point) + "원");
				$("#total").val(totalPayment - coupon - point);
				$("input[name=total_amount]").val(totalPayment - coupon - point);
				$("input[name=tax_free_amount]").val(totalPayment - coupon - point);
				
			}else{
				point = Number($("#point").val());				
				$("#totalPayment").html(addComma(totalPayment - coupon - point) + "원");
				$("#total").val(totalPayment - coupon - point);
				$("input[name=total_amount]").val(totalPayment - coupon - point);
				$("input[name=tax_free_amount]").val(totalPayment - coupon - point);
			}
		
		});
		
		
		$("#couponSelect").change(function(){
			
			if($("#couponSelect option:selected").val() == 0){
				$("#couponPrice").html("0원");
				coupon = 0;
				$("#totalPayment").html(addComma(totalPayment - coupon - point) + "원");
				$("#total").val(totalPayment - coupon - point);
				$("input[name=total_amount]").val(totalPayment - coupon - point);
				$("input[name=tax_free_amount]").val(totalPayment - coupon - point);
				
			}else{
				
				$("#couponPrice").html("-"+addComma($(this).val())+"원");
				coupon = $(this).val();				
				$("input[name=coupon_no_seq]").val($("#couponSelect option:selected").attr("id"));
				$("input[name=coupon_sale]").val($("#couponSelect option:selected").val());				
				$("#totalPayment").html(addComma(totalPayment - coupon - point) + "원");
				$("#total").val(totalPayment - coupon - point);
				$("input[name=total_amount]").val(totalPayment - coupon - point);
				$("input[name=tax_free_amount]").val(totalPayment - coupon - point);
				
			}
			
			
			
				
		});
		
	
		
		
	});
	

</script>


</head>
<body>

	<div>
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	
	<div class="paymentMain">
	<h1>결제하기</h1>	
	<br/>
	
	<h3>구매자 정보</h3>
	<hr/>
	<form action="pay.do" method="post" target="kakaoPay" id="form" >
	<input type="hidden" name="command" value="ready" />	
	<input type="hidden" name="partner_order_id" value="123" />
	<input type="hidden" name="partner_user_id" value="12" />
	<input type="hidden" name="item_name" value="${itemDto.item_name }" />
	<input type="hidden" name="quantity" value="${ea }" />
	<input type="hidden" name="total_amount" value="${itemDto.item_price * ea + post}" />
	<input type="hidden" name="tax_free_amount" value="${itemDto.item_price * ea + post}" />
	<input type="hidden" name="command" value="ready" />
	<input type="hidden" value="TC0ONETIME" name="cid" readonly="readonly" />
	<input type="hidden" value="http://192.168.10.33:8787/OPT222/paySuccess.jsp" name="approval_url" readonly="readonly" />
	<input type="hidden" value="http://192.168.10.33:8787/OPT222/payCancel.jsp" name="cancel_url" readonly="readonly" />
	<input type="hidden" value="http://192.168.10.33:8787/OPT222/payFail.jsp" name="fail_url" readonly="readonly" />
		<table class="user_table">
			<col width="200px" />
			<col width="200px" />
			<col width="200px" />	
			<tr>
				<td>이름</td>
				<td>${memdto.opt_name }</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${memdto.opt_email }</td>		
			</tr>
			<tr>
				<td>연락처</td>
				<td>${memdto.opt_phone }</td>		
			</tr>
		</table>
		<br/>
		
		<h3>배송지 정보</h3>
		<hr/>
		<table class="user_table">
			<col width="200px" />
			<col width="200px" />
			<col width="200px" />
			<tr>
				<td>배송주소</td>
				<td id="addr" width="500px">${memdto.opt_addr}</td>
				<td><input type="button" class="paymentBtn" value="배송지 변경" onclick="addrChange()"></td>
			</tr>
			<tr>
				<td>요청사항</td>
				<td width="500px"><input type="text" name="memo" placeholder="30자 미만으로 적어주세요" maxlength="30" size="50"/></td>
			</tr>
		</table>
		<br/>
		
		<h3>상품 정보</h3>
		<hr/>
		<table class="user_table">
			<col width="200px" />
			<col width="200px" />
			<col width="200px" />
			<tr>
				<td>상품이름</td>
				<td width="500px">${itemDto.item_name }</td>
			</tr>
			<tr>
				<td>수량</td>
				<td>${ea }개</td>
			</tr>
			<tr>
				<td>가격</td>
				<td><fmt:formatNumber value="${itemDto.item_price * ea }" pattern="#,##0"/>원</td>
			</tr>
		</table>
		<br/>
		
		<h3>결제정보</h3>
		<hr/>
		<table class="user_table">
			<col width="200px" />
			<col width="200px" />
			<col width="200px" />
			<tr>
				<td>총상품가격<input type="hidden" id="totalPrice" value="${itemDto.item_price * ea }"></td>
				<td><fmt:formatNumber value="${(itemDto.item_price * ea)+2500 }" pattern="#,##0"/>원</td>			
			</tr>
			<tr>
				<td>할인쿠폰</td>
				<td id="couponPrice">0원</td>
				<td>보유쿠폰 ${couponList.size() }장</td>
				<td>
					<select id="couponSelect">					
						<option value="0">쿠폰을 선택해 주세요</option>
						<c:choose>
							<c:when test="${empty couponList }">
								<option value="0">사용가능한 쿠폰이 없습니다.</option>
							</c:when>
							<c:otherwise>
								<c:forEach items="${couponList }" var="couponDto">
									<option value="${couponDto.coupon_sale }" id="${couponDto.coupon_no_seq }">${couponDto.coupon_name }</option>															
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</select>			
				</td>
			</tr>
			<tr>
				<td>포인트</td>
				<td><input type="number" id="point" name="point" value="0" 	min="0" max="${memdto.opt_point }" placeholder="사용할 포인트를 적어주세요" onkeydown="javascript: return event.keyCode == 110 ? false : true" /></td>	
				<td>보유포인트 <fmt:formatNumber value="${memdto.opt_point }" pattern="#,##0"/>p </td>	
			</tr>
			<tr>
				<td>배송비</td>
				<td>2,500원 <input type="hidden" value="2500" id="postPrice"/></td>		
			</tr>
			<tr>
				<td>총결제금액</td>
				<td id="totalPayment"></td>
				<td><input type="hidden" value="" id="total" name="totalPrice"></td>		
			</tr>		  
		</table>
		<br/>
		<br/>
		<br/>
		<img alt="" src="image/kakaoPay.png" onclick="formSubmit();" style="cursor: pointer;"/>
		<input type="hidden" name="coupon_no_seq" value="0" />
		<input type="hidden" name="coupon_sale" value="0" />		
		<input type="hidden" id="addrForm" name="addr" value="${memdto.opt_addr}"/>	
	</form>
	<br/>
	</div>
	
	<div class="foot_area_wrap">
	<%@ include file="./footer.jsp" %>
	</div>
<script type="text/javascript">
	function formSubmit(){
		ml = (screen.availWidth - 800) / 2;
		mt = (screen.availHeight - 600) / 2;
		kakaoWindow = window.open("","kakaoPay","width=800,height=600, scrollbars=no, left=" + ml + ", top=" + mt);		
		$('#form').submit();		
	}
</script>

</body>
</html>