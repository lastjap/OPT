package com.opt.controller;

import java.io.IOException;
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
import com.opt.dto.CouponDto;
import com.opt.dto.ItemDto;
import com.opt.dto.MemberDto;

/**
 * Servlet implementation class OptCouponController
 */
@WebServlet("/coupon.do")
public class OptCouponController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[ coupon.do?" + command + " ]");
		OPTBiz biz = new OPTBizImpl();
		if(command.equals("couponlist")) {
			HttpSession session = request.getSession();
			MemberDto memdto = (MemberDto)session.getAttribute("memdto");
			
			int page = Integer.parseInt(request.getParameter("page")); //현재페이징번호
			int allCount = biz.couponList(memdto.getOpt_no_seq()).size(); //전체게시글개수
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
			List<CouponDto> list = biz.couponPaging(memdto.getOpt_no_seq(), start, end);
			request.setAttribute("coupondto", list);
			request.setAttribute("page", page);
			request.setAttribute("blockCount", blockCount);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("absolutePage", absolutePage);
			request.setAttribute("endPage", endPage);
			
			dispatch(request, response, "coupon_popup.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	public void dispatch(HttpServletRequest request, HttpServletResponse response,String url) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

}
