<%@page import="com.opt.dao.OPTDao"%>
<%@page import="com.opt.biz.OPTBizImpl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.opt.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<title>Insert title here</title>
</head>
<body>
<%
	OPTDao dao = new OPTDao();
	OPTBizImpl biz = new OPTBizImpl();
	List<MemberDto> list = biz.selectList();
	System.out.print(list.get(0).getOpt_id());
%>
</body>
</html>