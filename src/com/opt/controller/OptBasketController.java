package com.opt.controller;

import java.io.IOException;
import java.io.PrintWriter;
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


@WebServlet("/basket.do")
public class OptBasketController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[ basket.do?" + command + " ]");
		OPTBiz biz = new OPTBizImpl();
		PrintWriter out = response.getWriter();
		
		// 장바구니DB에 상품 추가
		// 로그인여부는 itemdetail.jsp 에서  자바스크립트로 확인
		if(command.equals("basketinsert")) {
			int opt_no_seq = Integer.parseInt(request.getParameter("opt_no"));
			int basket_item_no = Integer.parseInt(request.getParameter("item_no"));
			int basket_item_count = Integer.parseInt(request.getParameter("item_ea"));
			int basket_item_price = Integer.parseInt(request.getParameter("item_price"));
			String basket_item_url = request.getParameter("item_url");
			String basket_item_name = request.getParameter("item_name");
			
			BasketDto basketDto = new BasketDto(opt_no_seq, basket_item_no, basket_item_url, basket_item_name, basket_item_count, basket_item_price);
			int res = biz.insertBasket(basketDto);
			out.print(res);
			
		}else if(command.equals("basketlist")) {			
			HttpSession session = request.getSession();
			
			int opt_no = ((Integer)(session.getAttribute("opt_no"))).intValue();
			
			List<BasketDto> basketList = biz.basketlist(opt_no);
			request.setAttribute("basketList", basketList);
			request.setAttribute("opt_no", opt_no);
			dispatch(request, response, "basket.jsp");
			
		}else if(command.equals("basketmuldel")) {
			
			String[] seq=request.getParameterValues("chk");
			boolean res=biz.muldelBasket(seq);
			
			if(seq==null||seq.length==0) {
				System.out.println("삭제할 목록을 하나 이상 체크해 주세요");
				alert("삭제할 목록을 하나 이상 체크해 주세요","basket.do?command=basketmuldel",response);			
						
			}else {
				
				if(res) {
					System.out.println("체크된 목록 삭제 완료!");
					alert("체크된 목록 삭제 완료!", "basket.do?command=basketlist", response);					
				}else {					
					System.out.println("체크된 목록 삭제 실패");
					alert("체크된 목록 삭제 실패!", "basket.do?command=basketlist", response);
				}
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
