package com.opt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.opt.dto.BasketDto;
import com.opt.dto.CouponDto;
import com.opt.dto.ItemCommentDto;
import com.opt.dto.ItemDto;
import com.opt.dto.MemberDto;


@WebServlet("/item.do")
public class OptItemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[ item.do?" + command + " ]");
		OPTBiz biz = new OPTBizImpl();
		PrintWriter out = response.getWriter();
		
		// 상품목록
		if(command.equals("itemlist")) {
			int page = Integer.parseInt(request.getParameter("page"));
			int allCount = biz.itemList().size();
			int listCount = 8;
			int totalPage = (allCount -1) / listCount + 1;
			int blockCount = 5;  
			int absolutePage = 0;
			int endPage = 0; 
			
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
			List<ItemDto> list = biz.itemPage(start, end);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			request.setAttribute("blockCount", blockCount);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("absolutePage", absolutePage);
			request.setAttribute("endPage", endPage);
			
			dispatch(request, response, "itemlist.jsp");
		//검색상품 목록	
		}else if(command.equals("itemsearch")) {
			String keyword = request.getParameter("keyword");
			String msg = request.getParameter("msg");
			
			int page = Integer.parseInt(request.getParameter("page"));
			int allCount = biz.itemSearch(keyword, msg).size();			
			int listCount = 8;
			int totalPage = (allCount -1) / listCount + 1;
			int blockCount = 5;  
			int absolutePage = 0;
			int endPage = 0; 
			
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
			request.setAttribute("list", biz.itemSearchPage(keyword, msg, start, end));			
			request.setAttribute("page", page);
			request.setAttribute("blockCount", blockCount);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("absolutePage", absolutePage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("keyword", keyword);
			request.setAttribute("msg", msg);
			
			dispatch(request, response, "itemsearch.jsp");
		// 상품 상세페이지	
		}else if(command.equals("itemdetail")) {
			int page = Integer.parseInt(request.getParameter("page"));
			int no = Integer.parseInt(request.getParameter("no"));
			biz.itemCount(no);
			ItemDto Itemdto = biz.itemSelect(no);
			List<ItemCommentDto> itemCommentList = biz.itemCommentList(Itemdto.getItem_num_seq());
			request.setAttribute("page", page);
			request.setAttribute("Itemdto", Itemdto);
			request.setAttribute("itemCommentList", itemCommentList);
			
			dispatch(request, response, "itemdetail.jsp");			
		// 상품결제 페이지	
		}else if(command.equals("payment")) {
			HttpSession session = request.getSession();
			int itemNo = Integer.parseInt(request.getParameter("no"));
			int itemEa = Integer.parseInt(request.getParameter("ea"));
			int post = 2500;
			
			// 로그인 여부 확인
			if(session.getAttribute("memdto") == null) {
				response.sendRedirect("login.jsp?Flag=2&itemno="+itemNo+"&itemea="+itemEa);
			}else {
				MemberDto memdto = (MemberDto)session.getAttribute("memdto");
				List<CouponDto> couponList = biz.couponList(memdto.getOpt_no_seq());
				ItemDto itemDto = biz.itemSelect(itemNo);
				session.setAttribute("couponList", couponList);
				session.setAttribute("itemDto", itemDto);	
				session.setAttribute("ea", itemEa);
				session.setAttribute("post", post);
				dispatch(request, response, "payment.jsp");
			}
		// 장바구니 결제페이지	
		}else if(command.equals("basketpayment")) {
			HttpSession session = request.getSession();	
			MemberDto memdto = (MemberDto)session.getAttribute("memdto");			
			List<CouponDto> couponList = biz.couponList(memdto.getOpt_no_seq());
			
			List<BasketDto> list = new ArrayList<BasketDto>();
			String[] seq = request.getParameterValues("chk");
			String count = request.getParameter("countarr");			
			String[] cnt = new String[seq.length];
			
			for(int i=0; i<cnt.length; i++) {
				cnt[i] = count.split(",")[i];
			}		
			
			for(int i=0; i<seq.length; i++) {
				BasketDto dto = new BasketDto();
				dto.setBasket_no_seq(Integer.parseInt(seq[i]));				
				dto.setBasket_item_count(Integer.parseInt(cnt[i]));
				list.add(dto);
			}
			
			if(biz.updateBasket(list)) {
				List<BasketDto> basketList = new ArrayList<BasketDto>();
				for(int i=0; i<seq.length; i++) {
					BasketDto dto = biz.selectBasket(Integer.parseInt(seq[i]));
					basketList.add(dto);
				}
				request.setAttribute("couponList", couponList);
				session.setAttribute("basketList", basketList);
				dispatch(request, response, "basketpayment.jsp");
			}else {
				alert("에러", "basket.do?command=basketlist", response);
			}
		}else if(command.equals("insertItemComment")) {
			HttpSession session = request.getSession();
			int itemPage = Integer.parseInt(request.getParameter("itemPage"));
			int itemNo = Integer.parseInt(request.getParameter("itemNo"));
			String content =  request.getParameter("content");
			MemberDto memberDto = (MemberDto)session.getAttribute("memdto");
			ItemCommentDto commentDto = new ItemCommentDto();
			
			commentDto.setOpt_no_seq(memberDto.getOpt_no_seq());
			commentDto.setItem_num_seq(itemNo);
			commentDto.setItem_comment_content(content);
			
			int res = biz.insertItemComment(commentDto);
			if(res > 0) {
				alert("댓글 작성 성공", "item.do?command=itemdetail&no="+itemNo+"&page="+itemPage, response);
			}else {
				alert("댓글 작성 실패", "item.do?command=itemdetail&no="+itemNo+"&page="+itemPage, response);
			}
		}else if(command.equals("deleteItemComment")) {
			int itemPage = Integer.parseInt(request.getParameter("itemPage"));
			int itemNo = Integer.parseInt(request.getParameter("itemNo"));
			int item_comment_no_seq = Integer.parseInt(request.getParameter("item_comment_no_seq"));
			
			int res = biz.deleteItemComment(item_comment_no_seq);
			if(res > 0) {
				alert("댓글 삭제 성공", "item.do?command=itemdetail&no="+itemNo+"&page="+itemPage, response);
			}else {
				alert("댓글 삭제 실패", "item.do?command=itemdetail&no="+itemNo+"&page="+itemPage, response);
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
		out.print("<script> alert('"+msg+"'); location.href='"+url+"'; </script>");
	}

}
