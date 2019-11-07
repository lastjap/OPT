<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/deliver_search.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title>Insert title here</title>
</head>
<script
  src="https://code.jquery.com/jquery-3.2.1.min.js"
  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
  crossorigin="anonymous"></script>
<script>

function closeNav() {
	document.getElementById('mysidenav').style.width = '0';
}

$(document).ready(function(){
	/* $(".side_menu_nav").mouseenter(function(){
		$("#mysidenav").width('250px');
	});
	$(".side_menu_nav").mouseleave(function(){
		$("#mysidenav").width('0px');
	}); */
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
	

$(document).ready(function(){
	var myKey = "wOUKvXq0nmNzi1hiW84eGA"; // sweet tracker에서 발급받은 자신의 키 넣는다.
	
		// 택배사 목록 조회 company-api
        $.ajax({
            type:"GET",
            dataType : "json",
            url:"http://info.sweettracker.co.kr/api/v1/companylist?t_key="+myKey,
            success:function(data){
            		
            		// 방법 1. JSON.parse 이용하기
            		var parseData = JSON.parse(JSON.stringify(data));
             		console.log(parseData.Company); // 그중 Json Array에 접근하기 위해 Array명 Company 입력
            		
            		// 방법 2. Json으로 가져온 데이터에 Array로 바로 접근하기
            		var CompanyArray = data.Company; // Json Array에 접근하기 위해 Array명 Company 입력
            		console.log(CompanyArray); 
            		
            		var myData="";
            		$.each(CompanyArray,function(key,value) {
	            			myData += ('<option value='+value.Code+'>'+value.Name + '</option>');        				
            		});
            		$("#tekbeCompnayList").html(myData);
            }
        });

		// 배송정보와 배송추적 tracking-api
        $("#myButton1").click(function() {
        	var t_code = $('#tekbeCompnayList option:selected').attr('value');
        	var t_invoice = $('#invoiceNumberText').val();
            $.ajax({
                type:"GET",
                dataType : "json",
                url:"http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key="+myKey+"&t_code="+t_code+"&t_invoice="+t_invoice,
                success:function(data){
                	console.log(data);
                	var myInvoiceData = "";
                	if(data.status == false){
                		myInvoiceData += ('<p>'+data.msg+'<p>');
                	}else{
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"보내는사람"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.senderName+'</td>');     				
	            		myInvoiceData += ('</tr>');     
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"제품정보"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.itemName+'</td>');     				
	            		myInvoiceData += ('</tr>');     
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"송장번호"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.invoiceNo+'</td>');     				
	            		myInvoiceData += ('</tr>');     
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"송장번호"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.receiverAddr+'</td>');     				
	            		myInvoiceData += ('</tr>');           	                		
                	}
        			
                	
                	$("#myPtag").html(myInvoiceData)
                	
                	var trackingDetails = data.trackingDetails;
                	
                	
            		var myTracking="";
            		var header ="";
            		header += ('<tr>');            	
            		header += ('<th>'+"시간"+'</th>');
            		header += ('<th>'+"장소"+'</th>');
            		header += ('<th>'+"유형"+'</th>');
            		header += ('<th>'+"전화번호"+'</th>');     				
        			header += ('</tr>');     
            		
            		$.each(trackingDetails,function(key,value) {
	            		myTracking += ('<tr>');            	
            			myTracking += ('<td>'+value.timeString+'</td>');
            			myTracking += ('<td>'+value.where+'</td>');
            			myTracking += ('<td>'+value.kind+'</td>');
            			myTracking += ('<td>'+value.telno+'</td>');     				
	            		myTracking += ('</tr>');        			            	
            		});
            		
            		$("#myPtag2").html(header+myTracking);
                	
                }
            });
        });
		
});


</script>
<body>

	<jsp:include page="header.jsp"></jsp:include>

	<div class="deliver_title">
		<h1>운송장 번호 조회</h1>
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
		<a onclick="coupon_popup();">내쿠폰함</a>
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
	
	<div class="deliver_contents_aera">
	<div class="deliver_content">
	
<span id="tekbeCompnayName">택배회사명: </span>
<select id="tekbeCompnayList" name="tekbeCompnayList"></select><br/><br/>

<div class="num_search">
<span id="invoiceNumber">운송장번호: </span>
<input type="text" id="invoiceNumberText" name="invoiceNumberText" style="width: 390px;">
<img id="myButton1" alt="" src="./deliver_img/icon_sch_big.png">
</div>
</div>
<br/>
<br/>
<div class="search_area">
	<table id="myPtag"></table>

<br/>
	<table id="myPtag2"></table>
</div>
</div>
	<div class="foot_area_wrap">
	<jsp:include page="footer.jsp"></jsp:include>
	</div>

</body>
</html>