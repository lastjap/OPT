package com.opt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.opt.biz.OPTBiz;
import com.opt.biz.OPTBizImpl;
import com.opt.dto.ItemDto;
import com.opt.dto.MemberDto;

@WebServlet("/admin.do")
public class OptAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public OptAdminController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[" + command + "]");
		OPTBiz biz = new OPTBizImpl();
		PrintWriter out = response.getWriter();
		
		// (관리자) 유저관리
		if(command.equals("adminUserManager")) {
			// 한 화면에 찍을 페이지 수
			int countPage = 3;
			// 한 화면에 찍을 유저 수
			int countList = 3;
			// 현재 페이지
			int page = Integer.parseInt(request.getParameter("page"));
			// 총 유저 수
			List<MemberDto> memList = biz.selectList();
			int totalCount = memList.size();
			// 총 페이지 수
			int totalPage = totalCount / countList;
			// 페이지에 찍는 페이지가 남을 때 totalPage 보정
			if(totalCount % countList > 0) { totalPage++; }
			// 시작 페이지
			int startPage = ((page-1) / countPage) * countPage + 1;
			// 끝 페이지
			int endPage = startPage + countPage - 1;
			// 끝 페이지가 총 페이지보다 클 경우 끝 페이지를 총 페이지로 맞춤
			if(endPage > totalPage) { endPage = totalPage; }
			// 첫번째 목록
			int startCount = (page-1) * countList + 1;
			// 마지막 목록
			int endCount = page * countList;

			List<MemberDto> list = biz.adminUserPaging(startCount, endCount);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("memberList", list);
			dispatch(request, response, "admin_user_manager.jsp");
		// (유저관리)수정 버튼 누르면 유저 정보 업데이트 실행
		} else if(command.equals("adminUserUpdate")) {
			String id = request.getParameter("id");
			String enabled = request.getParameter("enabled");
			String role = request.getParameter("role");
			int res = biz.adminUserUpdate(id, enabled, role);
			if(res > 0) {
				out.print("유저 수정 완료");
			}
		// (관리자) 상품관리
		} else if(command.equals("adminItemManager")) {
			// 한 화면에 찍을 페이지 수
			int countPage = 4;
			// 한 화면에 찍을 상품 수
			int countList = 3;
			// 현재 페이지
			int page = Integer.parseInt(request.getParameter("page"));
			// 총 상품 수
			List<ItemDto> itemList = biz.itemList();
			int totalCount = itemList.size();
			// 총 페이지 수
			int totalPage = totalCount / countList;
			// 페이지에 찍는 상품이 남을 때 totalPage 보정
			if(totalCount % countList > 0) { totalPage++; }
			// 시작 페이지
			int startPage = ((page-1) / countPage) * countPage + 1;
			// 끝 페이지
			int endPage = startPage + countPage - 1;
			// 끝 페이지가 총 페이지보다 클 경우 끝 페이지를 총 페이지로 맞춤
			if(endPage > totalPage) { endPage = totalPage; }
			// 첫번째 목록
			int startCount = (page-1) * countList + 1;
			// 마지막 목록
			int endCount = page * countList;
			
			List<ItemDto> list = biz.adminItemPaging(startCount, endCount);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("itemList", list);
			dispatch(request, response, "admin_item_manager.jsp");
		// (관리자) 상품정보 수정
		} else if(command.equals("adminItemUpdate")) {
			String item_num_seq = request.getParameter("item_num_seq");
			String item_name = request.getParameter("item_name");
			String item_price = request.getParameter("item_price");
			String item_content = request.getParameter("item_content");
			int page = Integer.parseInt(request.getParameter("page"));
			request.setAttribute("page", page);
			request.setAttribute("item_num_seq", item_num_seq);
			request.setAttribute("item_name", item_name);
			request.setAttribute("item_price", item_price);
			request.setAttribute("item_content", item_content);
			dispatch(request, response, "admin_item_update_form.jsp");
		// (관리자) 상품정보 수정 실행
		} else if(command.equals("adminItemUpdateRes")) {
			String item_num_seq = request.getParameter("item_num_seq");
			String item_name = request.getParameter("item_name");
			String item_price = request.getParameter("item_price");
			String item_content = request.getParameter("item_content");
			Map<String, String> update = new HashMap<String, String>();
			update.put("item_num_seq", item_num_seq);
			update.put("item_name", item_name);
			update.put("item_price", item_price);
			update.put("item_content", item_content);
			int res = biz.adminItemUpdate(update);
			if(res > 0) {
				out.print("상품 수정 완료");
			}
		// (관리자) 상품 판매 시작
		} else if(command.equals("adminItemUnDelete")) {
			String[] item_num_seq = request.getParameterValues("item_num_seq");
			Map<String, String[]> unDelete = new HashMap<String, String[]>();
			unDelete.put("item_num_seq", item_num_seq);
			int res = biz.adminItemUnDelete(unDelete);
			if(res > 0) {
				out.print("선택한 상품이 판매가 시작되었습니다");
			}
		// (관리자) 상품 판매 중지
		} else if(command.equals("adminItemDelete")) {
			String[] item_num_seq = request.getParameterValues("item_num_seq");
			Map<String, String[]> delete = new HashMap<String, String[]>();
			delete.put("item_num_seq", item_num_seq);
			int res = biz.adminItemDelete(delete);
			if(res > 0) {
				out.print("선택한 상품이 판매중지 되었습니다");
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

}
