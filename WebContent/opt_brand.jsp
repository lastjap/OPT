<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title>Insert title here</title>
<!-- 참고사이트 ssgblog.com/5 -->
 <style> 
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
    
    .footer_wrap_area{
    position: relative;
    top: 55px;
    }
    
    
body{
	margin:0;
	padding:0;
	border:0;
	
}

ul,li{
	list-style:none;
	margin:0;
	padding:0;
}
setion {
	display:block;
}

a {
	text-decoration: none;
}
.content_wrap{
	width: 1200px;
    margin: 0 auto;

}
.opt_title h2{
width:auto;
	text-align: center;
	background: rgb(105, 1, 143);
	color: white;
	font-weight: bold;
	padding: 70px;
	font-size: 2em;
	border-radius: 30px 30px 30px 30px;
}

.contentTitle{
    font-size: 28px;
    font-weight: 700;
    color: #654949;
}
.titleSub{
    font-size: 26px;
    font-weight: 700;
    color: #654949;
    
}
.content{
    font-size: 18px;
    font-weight: 600;
    color: #635f5f;
}
.contentwrap{
 	height: 160px;
	padding: 20px;
	padding-top: 20px;
}
.busiTitle{
	font-size: 21px;
    font-weight: 600;
    color: #483b47;

}
.map_wrap{
 	width: 1200px;
    height: 500px;
    margin-top: 50px;
    padding-left: 20px;
   }
hr{
	border-style: solid;
    border-color: #ebebeb;
} 
#map{
    margin-top: 30px;
}  
    ::selection{
background: rgb(242, 207, 255);	
}
.margin-top-8px{
margin-top: 8px;
}
.map_content{
    position: relative;
    left: 600px;
    bottom: 368px;
    font-size: 15px;
    color: #817c8e;
    font-weight: 600;
    width: 320px;
}

</style>
<!-- <link href="css/opt_brand.css" rel="stylesheet" type="text/css"> -->
</head>
<body>
	
	<jsp:include page="header.jsp"></jsp:include>
	<div class="content_wrap">
	<div class="opt_title">
		<h2>OPT는<br> 우리의 가치, 창조의 가치<br> 그리고 성취의 가치를 중요시 합니다.</h2>
	</div>	
	<div class="contentwrap">
	<span class="contentTitle">OPT의 비전</span> <span class="titleSub"> (Vision)</span> <br><br><br> 
	<span class="content">누군가의 꿈이 현실로 이루어지면서 세상은 더 좋은 곳으로 발전하고 있습니다. <br> </span>
	<div class="content margin-top-8px">운동에서 시작하여 다양한 문화의 영역에서 무한한 상상을 현실로 만드는 창조집단, 그것이 OPT의 비전입니다.<br></div>
	</div>
	<hr>
	<div class="contentwrap">
	<span class="contentTitle">OPT의 핵심가치</span> <span class="titleSub"> (Core values of OPT)</span><br><br>
	<span class="content">OPT는 회사의 이름 그 자체가 회사가 추구하는 핵심 가치를 내포하고 있습니다. <br></span>
	<div class="content margin-top-8px">Oline과 Personal Trainning의 조합인 OPT는 공간과 비용을 절감하여 우리 모두를 행복하게  만든다라는 뜻으로,<br></div>
	<div class="content margin-top-8px">기업 행위의 주체, 행위의 내용 그리고 행위의 결과를 암시합니다. <br></div>
	<div class="content margin-top-8px">그  무엇이든지 될 수 있지만 그 대상이 갖춰야 할 필수 가치를 한정하는 형태로 이루어져 있습니다.<br></div>
	</div>
	<br>
	<hr>	
	<div  class="contentwrap">
		<span class="contentTitle">사업영역</span><br><br>
	<span class="busiTitle">O(Online)</span> <span class="content">  : PT 동영상 제공 및 트레이너 매칭</span><br>
	<div class="margin-top-8px"><span class="busiTitle">P(Personal)</span> <span class="content">: 개인별 식단 추천 및 운동법 제공</span></div>
	<div class="margin-top-8px"><span class="busiTitle">T(Training)</span> <span class="content">: 지속적인 운동 욕구 자극</span></div>
	</div>
	<hr>	
	<div class="map_wrap">
	<span class="contentTitle">오시는길</span><br>	
	<div id="map" style="width:550px;height:350px;"></div>
	<div class="map_content">
		<div class="map_info">
					<p>서울특별시 강남구 테헤란로 <em>14</em></p>
					<p> 하나금융그룹 강남사옥 남도빌딩 <em>2F, 3F, 4F, 5F</em></p>
					<p>대표전화 <em>1588-9988</em></p>
					<p> 통신판매업신고 <em>2016</em>-서울강남-<em>03054</em></p>
					<p> 사업자등록번호 <em>126-81-38772</em></p>
					<p> 이메일 <em>admin1234@naver.com</em></p>
		</div>			
	</div>
	</div>

	</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=166c35471279ee679a666dea66875cae&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.498980, 127.032865), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//지도에 마커를 표시합니다 
var marker = new kakao.maps.Marker({
 map: map, 
 position: new kakao.maps.LatLng(37.498980, 127.032865)
});

//커스텀 오버레이에 표시할 컨텐츠 입니다
//커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
//별도의 이벤트 메소드를 제공하지 않습니다 
var content = '<div class="wrap">' + 
         '    <div class="info">' + 
         '        <div class="title">' + 
         '            OPT' + 
         '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
         '        </div>' + 
         '        <div class="body">' + 
         '            <div class="img">' +
         '                <img src="main_image/logo2.png" width="72" height="72">' +
         '           </div>' + 
         '            <div class="desc">' + 
         '                <div class="ellipsis">서울특별시 강남구 역삼동</div>' + 
         '                <div class="jibun ellipsis">강남구 테헤란로 14길 6</div>' + 
         '                <div><a href="index.jsp" target="_blank" class="link">홈페이지</a></div>' + 
         '            </div>' + 
         '        </div>' + 
         '    </div>' +    
         '</div>';

//마커 위에 커스텀오버레이를 표시합니다
//마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
var overlay = new kakao.maps.CustomOverlay({
 content: content,
 map: map,
 position: marker.getPosition()       
});

//마커를 클릭했을 때 커스텀 오버레이를 표시합니다
kakao.maps.event.addListener(marker, 'click', function() {
 overlay.setMap(map);
});

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
 overlay.setMap(null);     
}
</script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script> -->

		<div class="footer_wrap_area">
		<jsp:include page="footer.jsp"></jsp:include>
		</div>
		
</body>
</html>