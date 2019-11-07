<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<link href="css/admin_item_update_form.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
<%
	// 현재 페이지
	int nowpage = Integer.parseInt(request.getParameter("page"));
%>
	$(function() {
		$(".itemUpdate").click(function() {
			var item_name = $("input[name=item_name]").val();
			var item_price = $("input[name=item_price]").val();
			var item_content = $("textarea[name=item_content]").val();
			$.ajax({
				url : "admin.do?command=adminItemUpdateRes",
				type : "POST",
				data : {"item_num_seq" : "${item_num_seq}", "item_name" : item_name,
						"item_price" : item_price, "item_content" : item_content},
				dataType : "html",
				success : function(data) {
					alert(data);
					$(opener.document)
					.find(".adminItemManagerPopup")
					.load("admin.do?command=adminItemManager&page="+<%=nowpage%>, function() { self.close(); });
				},
				error : function(request, status, error) {
					alert("상품 수정 실패");
					alert(request.status);
					alert(request.responseText);
					alert(status);
					alert(error);
				}
			});
		});
	});
</script>
<table>
	<tr>
		<th>상품이름</th>
		<td><input type="text" name="item_name" value="${item_name}"></td>
	</tr>
	<tr>
		<th>가격</th>
		<td><input type="text" name="item_price" value="${item_price}"></td>
	</tr>
	<tr>
		<th>상품설명</th>
		<td><textarea rows="5" cols="21" name="item_content"><c:out value="${item_content}"/></textarea></td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: center; padding-top: 20px;">
			<input type="button" class="itemUpdate" value="수정">
			<input type="button" value="취소" onclick="self.close();">
		</td>
	</tr>
</table>