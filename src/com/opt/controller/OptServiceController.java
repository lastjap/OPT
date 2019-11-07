package com.opt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.opt.biz.OPTBiz;
import com.opt.biz.OPTBizImpl;
import com.opt.dto.AdminAnswerDto;
import com.opt.dto.CouponDto;
import com.opt.dto.CustomerServiceDto;
import com.opt.dto.FaqDto;

@WebServlet("/service.do")
public class OptServiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[ service.do?" + command + " ]");
		OPTBiz biz = new OPTBizImpl();
		PrintWriter out = response.getWriter();
		if(command.equals("servicelist")) {
			HttpSession session = request.getSession();

			int page = Integer.parseInt(request.getParameter("page")); //현재페이징번호
			int allCount = biz.customerList().size(); //전체게시글개수
			int listCount = 5; //한 화면에 뿌릴 데이터 개수
			int totalPage = (allCount -1) / listCount + 1; // 전체 페이지 개수
			int blockCount = 5;  // 이동을 위한 페이지 표시에 나타나는 숫자의 표시 갯수( 예 [1] [2] [3])
			int absolutePage = 0; // 페이지를 넘겼을 때 시작되는 첫번째 게시물의 시작 번호
			int endPage = 0;  // 페이지 마지막 번호
			
			if(page < 1) {
				page = 1;
				
			}else if(page > totalPage) {
				page = totalPage;
			}
			
			if(page%5 == 0) {
				absolutePage = ((page/5) *5) -4;
				endPage = (page / 5) * 5;
				
			}else {
				absolutePage = ((page /5) *5)+1;
				endPage = ((page/5) * 5) + 5;
			}
			
			if(endPage > totalPage) {
				endPage = totalPage;
			}
			
			int start = (page - 1)*listCount +1;
			int end = page * listCount;
			List<CustomerServiceDto> list = biz.customerPaging(start, end);
			
			session.setAttribute("customerdto", list);
			request.setAttribute("page", page);
			request.setAttribute("blockCount", blockCount);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("absolutePage", absolutePage);
			request.setAttribute("endPage", endPage);
			
			List<AdminAnswerDto> answerList = biz.adminanswerList();			
			session.setAttribute("answerList", answerList);
			
			dispatch(request, response, "customer.jsp");
		} else if (command.equals("insertres")) {
			int opt_no_seq = Integer.parseInt(request.getParameter("opt_no_seq"));
			String customer_title = request.getParameter("customer_title");
			String customer_content = request.getParameter("customer_content");
			CustomerServiceDto customerServiceDto = new CustomerServiceDto();
			customerServiceDto.setOpt_no_seq(opt_no_seq);
			customerServiceDto.setCustomer_title(customer_title);
			customerServiceDto.setCustomer_content(customer_content);
			int res = biz.insertCustomerBoard(customerServiceDto);
			if(res > 0) {
				response.sendRedirect("service.do?command=servicelist&page=1");
			}else {
				response.sendRedirect("service.do?command=servicelist&page=1");
			}
		} else if (command.equals("faqlist")) {
			HttpSession session = request.getSession();
			
			int page = Integer.parseInt(request.getParameter("page")); //현재페이징번호
			int allCount = biz.faqList().size(); //전체게시글개수
			int listCount = 5; //한 화면에 뿌릴 데이터 개수
			int totalPage = (allCount -1) / listCount + 1; // 전체 페이지 개수
			int blockCount = 5;  // 이동을 위한 페이지 표시에 나타나는 숫자의 표시 갯수( 예 [1] [2] [3])
			int absolutePage = 0; // 페이지를 넘겼을 때 시작되는 첫번째 게시물의 시작 번호
			int endPage = 0;  // 페이지 마지막 번호
			
			if(page < 1) {
				page = 1;
				
			}else if(page > totalPage) {
				page = totalPage;
			}
			
			if(page%5 == 0) {
				absolutePage = ((page/5) *5) -4;
				endPage = (page / 5) * 5;
				
			}else {
				absolutePage = ((page /5) *5)+1;
				endPage = ((page/5) * 5) + 5;
			}
			
			if(endPage > totalPage) {
				endPage = totalPage;
			}
							
			int start = (page - 1)*listCount +1;
			int end = page * listCount;
			System.out.println("start >> " + start);
			System.out.println("end >> " + end);
			List<FaqDto> list = biz.faqListPage(start, end);
			session.setAttribute("list", list);
			request.setAttribute("page", page);
			request.setAttribute("blockCount", blockCount);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("absolutePage", absolutePage);
			request.setAttribute("endPage", endPage);

			dispatch(request, response, "customer_often_FAQ.jsp");

		} else if(command.equals("adminanswer")) {
			int opt_no_seq = Integer.parseInt(request.getParameter("opt_no_seq"));
			int customer_no_seq = Integer.parseInt(request.getParameter("customer_no_seq"));
			String admin_answer_content = request.getParameter("admin_answer_content");
			
			System.out.println(opt_no_seq);
			System.out.println(customer_no_seq);
			System.out.println(admin_answer_content);
			
			AdminAnswerDto adminDto = new AdminAnswerDto();
			adminDto.setCustomer_no_seq(customer_no_seq);
			adminDto.setOpt_no_seq(opt_no_seq);
			adminDto.setAdmin_answer_content(admin_answer_content);
			
			
			int res = biz.adminAnswer(adminDto);
			
			if(res > 0) {
				out.print("<script> alert('작성성공');  opener.location.reload(); close();</script>");
			}else {
				out.print("<script> alert('작성실패'); opener.location.reload(); close();</script>");
			}
			
			
		} else if(command.equals("adminAnswerDelete")) {
			int admin_answer_no_seq = Integer.parseInt(request.getParameter("admin_answer_no_seq"));
			int res = biz.adminAnswerDelete(admin_answer_no_seq);
			if(res > 0) {
				alert("삭제성공","service.do?command=servicelist&page=1", response);
			}else {
				alert("삭제실패","service.do?command=servicelist&page=1", response);
			}
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public void dispatch(HttpServletRequest request, HttpServletResponse response,String url) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	
	public void alert(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		out.print("<script> alert('" + msg + "'); location.href='" + url + "'; </script>");
	}	
	
}
