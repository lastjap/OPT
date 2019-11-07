<%@page import="java.sql.Date"%>
<%@page import="com.opt.dto.FaqDto"%>
<%@page import="com.opt.dto.CustomerServiceDto"%>
<%@page import="com.opt.dto.AdminAnswerDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/customer.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title>Insert title here</title>
<style type="text/css">
	.foot_wrap_area{
		position: relative;
		top: 54px;
	}
	#costomer_text{
	width: 98%;
    margin: 0 auto;
    border-top: 1px solid #ebebeb;
    padding: 11px 0;
    margin-top: 18px;
    padding-left: 36px;
	}
	.costomer_img{
	width: 26px;
    height: 26px;
    background: url(./image/ico_q.png) no-repeat;
	}
	.answer_img{
	width: 26px;
    height: 26px;
    background: url(./image/ico_a.png) no-repeat;
	}
	#faq_div{
	cursor: pointer;
	}
	.menu_li a{
		background-color: #ebebeb;
	}
	
	
	.ans_Btn{
	    background-color: #cbb795;
    cursor: pointer;
    border: none;
    color: #fff;
    font-weight: 600;
    padding: 8px;
    font-size: 15px;
    margin-top: 30px;
    border-radius: 10px;
    position: relative;
    left: 1040px;
    bottom: 100px;
	}
	.answer_area{
	    height: 100px;
	}
	
	.service_content_wrap {
    height: 1100px;
	}
	
	/* .answer_area{
	 border-top: 1px solid #ebebeb;
    position: relative;
    top: 36px;
    padding-right: 25px;
	} */
	.answer_wrap{
	
	}
	
    .answer{
    position: relative;
    top: 54px;
    
    }
</style>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">

$(document).ready(function(){
    //$("#costomer_text").hide();
    // $("ul > li:first-child a").next().show();
    $("#faq #faq_div").click(function(){
      $(this).next().slideToggle(300);
      // $(this).next().slideDown(300);
      $("#faq #faq_div").not(this).next().slideUp(300);
      return false;
    });
    $("#faq #faq_div").eq(0).trigger("click");
    
	if("${memdto.opt_role}" == "admin"){
		$(".answerBtn").attr("style","display:'';");
	}else{
		$(".answerBtn").attr("style","display:none;");
	}
    
  });



function adminAnswer(customer_no_seq) {
	
	open("adminReply.jsp?customer_no_seq="+customer_no_seq,"","width:850px;height:380px;")
}


function adminAnswerDelete(admin_answer_no_seq) {
	
	location.href="service.do?command=adminAnswerDelete&admin_answer_no_seq="+admin_answer_no_seq;
}
	
</script>
</head>
<%
	List<CustomerServiceDto> customerList = (List)session.getAttribute("customerdto");	
	List<AdminAnswerDto> answerList = (List)session.getAttribute("answerList");
%>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	
	<div class="service_content_wrap">
		<h3>고객 QNA</h3>
	<div class="category_menu">
		<ul>
			<li>
				<a href="service.do?command=faqlist&page=1">자주묻는질문</a>
			</li>
			<li class="menu_li">
				<a href="#">고객 QNA</a>
			</li>
		</ul>
	</div>
	<div class="coupon_list">
			<table summary="글 번호 글 제목 글 작성일 이름">
				<colgroup>
					<col width="80">
					<col width="*">
					<col width="100">
					<col width="180">
				</colgroup>
					<tr>
						<th>
							<div class="th_title">글 번호</div>
						</th>
						<th>
							<div class="th_title">글 제목</div>
						</th>
						<th>
							<div class="th_title">작성자</div>
						</th>
						<th>
							<div class="th_title">글 작성일</div>
						</th>
					</tr>
				</table>
	 		<div class="costomer_list_div">
	 			<ul class="costomer_list_ul">
<%
	if(customerList == null){
%>
			<li>
				----------------내용이없습니다-------
			</li>			
<%		
	}else{
		for(int i=0; i<customerList.size(); i++){
%>
			<li id="faq">
				<div id="faq_div">
				<p class="costomer_p_one"><%=customerList.get(i).getCustomer_no_seq() %></p>
				<p class="costomer_p_two"><%=customerList.get(i).getCustomer_title() %></p>
				<p class="costomer_p_three"><%=customerList.get(i).getOpt_id() %></p> 
				<p class="costomer_p_four"><fmt:formatDate value="<%=customerList.get(i).getCustomer_regdate() %>" pattern="yyyy-MM-dd" /></p>
				</div>
			 	<div id="costomer_text">
			 	<div class="costomer_img"></div>
			 	<div class="text_area"><p class="cosutomer_textcontent"><%=customerList.get(i).getCustomer_content() %></p></div>
			 	<div class="answerBtn answer" style="display: none"><input type="button" class="ans_Btn" value="답변하기" onclick="adminAnswer(<%=customerList.get(i).getCustomer_no_seq() %>);"></div>			 				
<%			
			for(int j=0; j<answerList.size(); j++){
				if(answerList.get(j).getCustomer_no_seq() == customerList.get(i).getCustomer_no_seq()){
%>	
				<div class="answer_wrap">
				<div class="answer_area">
				<div class="answer_img"></div>
				<div class="answer_area"><p class="answer_textcontent"><%=answerList.get(j).getAdmin_answer_content() %></div>				
				<div class="answerBtn delebtn" style="display: none"><input type="button" class="ans_Btn" value="삭제하기" onclick="adminAnswerDelete(<%=answerList.get(j).getAdmin_answer_no_seq() %>);"></div>
				</div>			
				</div>
<%					
				}
			}
%>
				</div>
			</li>
<%		
		
		}
	}
%>	 			

			</ul>
			<input type="button" class="btn" value="글작성"	onclick="location.href='customerwrite.jsp'"/>
		</div>	
	</div>
	<div class="paging">
			<ul class="paging_ul">
			<c:set var="prevPage" value="${absolutePage-blockCount}"></c:set>
			<c:choose>
				<c:when test="${prevPage >0}">
					<li><a href="service.do?command=servicelist&page=${prevPage }">◀</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="service.do?command=servicelist&page=1">◀</a></li>
				</c:otherwise>
			</c:choose>
			<c:forEach begin="${absolutePage }" end="${endPage }" var="i">
				<c:choose>
				<c:when test="${i eq page}">
					<li><a href="service.do?command=servicelist&page=${i}">${ i }</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="service.do?command=servicelist&page=${i}">${ i }</a></li>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:set var="nextPage" value="${absolutePage+blockCount }"></c:set>
			<c:choose>
				<c:when test="${nextPage < totalPage}">
					<li><a href="service.do?command=servicelist&page=${nextPage }">▶</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="service.do?command=servicelist&page=${totalPage}">▶</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
	
	<div class="foot_wrap_area">
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>