package com.opt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.opt.biz.OPTBiz;
import com.opt.biz.OPTBizImpl;
import com.opt.dao.OPTDao;
import com.opt.dto.CalendarDto;
import com.opt.dto.CouponDto;
import com.opt.dto.ItemDto;
import com.opt.dto.MemberDto;
import com.opt.dto.OrderListDto;
import com.opt.dto.PaymentDto;

@WebServlet("/opt.do")
public class OptController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[ opt.do?" + command + " ]");
		OPTBiz biz = new OPTBizImpl();
		PrintWriter out = response.getWriter();

		// 마이페이지
		 if(command.equals("mypage")) {
			HttpSession session = request.getSession();
			if(session.getAttribute("memdto") == null) {
				response.sendRedirect("login.jsp?Flag=1");
			} else {
				MemberDto memdto = (MemberDto)session.getAttribute("memdto");
				// 관리자가 마이페이지 클릭 시 관리자 전용 페이지로 이동
				if(memdto.getOpt_role().equals("admin")) {
					Calendar cal = Calendar.getInstance();
					int year = cal.get(Calendar.YEAR);
					int month = cal.get(Calendar.MONTH)+1;
					int date = cal.get(Calendar.DAY_OF_MONTH);
					List<PaymentDto> list = biz.paymentAllList();
					// 두달전
					int beforeTwoMonth = 0;
					// 한달전
					int beforeOneMonth = 0;
					// 이틀전
					int beforeTwoDay = 0;
					// 하루전
					int beforeOneDay = 0;
					// 이번달
					int thisMonth = 0;
					// 오늘
					int today = 0;
					for(PaymentDto dto : list) {
						// 2달전, 1달전, 이번달 판매 개수
						if(dto.getPay_date().getMonth()+1 == (month-2)) {
							beforeTwoMonth++;
						} else if(dto.getPay_date().getMonth()+1 == (month-1)) {
							beforeOneMonth++;
						} else if(dto.getPay_date().getMonth()+1 == month) {
							thisMonth++;
						}
						// 2일전, 1일전, 오늘 판매 개수
						if(dto.getPay_date().getDate() == (date-2) && dto.getPay_date().getMonth()+1 == month) {
							beforeTwoDay++;
						} else if(dto.getPay_date().getDate() == (date-1) && dto.getPay_date().getMonth()+1 == month) {
							beforeOneDay++;
						} else if(dto.getPay_date().getDate() == date && dto.getPay_date().getMonth()+1 == month) {
							today++;
						}
					}
					request.setAttribute("beforeTwoMonth", beforeTwoMonth);
					request.setAttribute("beforeOneMonth", beforeOneMonth);
					request.setAttribute("beforeTwoDay", beforeTwoDay);
					request.setAttribute("beforeOneDay", beforeOneDay);
					request.setAttribute("thisMonth",thisMonth);
					request.setAttribute("today", today);
					dispatch(request, response, "admin.jsp");
				} else {
					int pay_count = biz.pay_count(memdto.getOpt_no_seq());
					int coupon_count = biz.coupon_count(memdto.getOpt_no_seq());
					
					List<OrderListDto> orderList = new ArrayList<OrderListDto>();
					orderList = biz.orderList(memdto.getOpt_no_seq());
					
					session.setAttribute("orderdto", orderList);
					dispatch(request, response, "user.jsp?pay_count="+pay_count+"&coupon_count="+coupon_count);
				}
			}
		//회원 일정 등록
		}else if(command.equals("cal_insert")) {
			String cal_title = request.getParameter("cal_title");
			String cal_start = request.getParameter("cal_start");
			String cal_end = request.getParameter("cal_end");
			HttpSession session = request.getSession();
			MemberDto memdto = (MemberDto)session.getAttribute("memdto");
			CalendarDto caldto = new CalendarDto();
			
			caldto.setOpt_no_seq(memdto.getOpt_no_seq());
			caldto.setCalendar_title(cal_title);
			caldto.setCalendar_startday(cal_start);
			caldto.setCalendar_enddate(cal_end);
			
			
			int res = biz.insertCalendar(caldto);
			if(res > 0) {
				System.out.println("insert 성공!");
				out.println("success");
			}else {
				System.out.println("insert 실패");
				out.println("fail");
			}
		//회원 일정 페이지	
		}else if(command.equals("calendar")) {
			HttpSession session = request.getSession();
			MemberDto memdto = (MemberDto)session.getAttribute("memdto");
			List<CalendarDto> callist = new ArrayList<CalendarDto>();
			int opt_no_seq = memdto.getOpt_no_seq();
			callist = biz.Callist(opt_no_seq);

			JSONObject object = new JSONObject();
			JSONArray Jarray = new JSONArray();
			for(int i = 0; i < callist.size(); i++) {
				JSONObject jobject = new JSONObject();
				jobject.put("id", callist.get(i).getCalendar_no_seq());
				jobject.put("title",callist.get(i).getCalendar_title());
				jobject.put("start",callist.get(i).getCalendar_startday());
				jobject.put("end",callist.get(i).getCalendar_enddate());
				jobject.put("count",callist.get(i).getCount());
				jobject.put("nextdate", callist.get(i).getNextDate());
				Jarray.add(jobject);
			}
			
			object.put("cal", Jarray);
			out.print(object);
		//회원 일정 상세페이지	
		}else if(command.equals("caldetail")) {
			int cal_no_seq = Integer.parseInt(request.getParameter("id"));
			
			CalendarDto caldto = biz.CalllistOne(cal_no_seq);
			HttpSession session = request.getSession();
			session.setAttribute("caldto", caldto);
			dispatch(request, response, "caldetail.jsp");
		//회원 일정 수정
		}else if(command.equals("cal_update")) {
			int cal_no_seq = Integer.parseInt(request.getParameter("idx"));
			
			
			String cal_title = request.getParameter("cal_title");
			String cal_start = request.getParameter("cal_start");
			String cal_end = request.getParameter("cal_end");
			
			CalendarDto caldto = new CalendarDto();
			caldto.setCalendar_no_seq(cal_no_seq);
			caldto.setCalendar_title(cal_title);
			caldto.setCalendar_startday(cal_start);
			caldto.setCalendar_enddate(cal_end);
			int res = biz.updateCalendar(caldto);
			if(res > 0) {
				System.out.println("update 성공!");
				out.println("success");
			}else {
				System.out.println("update 실패");
				out.println("fail");
			}
		//회원 일정 삭제	
		}else if(command.equals("cal_delete")) {
			int cal_no_seq = Integer.parseInt(request.getParameter("idx"));
			
			int res = biz.deleteCalendar(cal_no_seq);
			
			if(res > 0) {
				System.out.println("insert 성공!");
				out.println("success");
			}else {
				System.out.println("insert 실패");
				out.println("fail");
			}
		//회원 일정 막대 옴길때	
		}else if(command.equals("updateDrop")) {
			int cal_no_seq = Integer.parseInt(request.getParameter("idx"));
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			
			CalendarDto caldto = new CalendarDto();
			caldto.setCalendar_no_seq(cal_no_seq);
			caldto.setCalendar_startday(start);
			caldto.setCalendar_enddate(end);
			
			int res = biz.updateCalendarDrop(caldto);
			if(res > 0) {
				System.out.println("drop성공!");
			}else {
				System.out.println("drop 실패!");
			}
			dispatch(request, response, "calendar.jsp");
		//회원 일정 막대사이즈 늘리기/줄이기
		}else if(command.equals("updateResize")) {
			int cal_no_seq = Integer.parseInt(request.getParameter("idx"));
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			
			CalendarDto caldto = new CalendarDto();
			caldto.setCalendar_no_seq(cal_no_seq);
			caldto.setCalendar_startday(start);
			caldto.setCalendar_enddate(end);
			
			int res = biz.updateCalendarResize(caldto);
			if(res > 0) {
				System.out.println("resize 성공!");
			}else {
				System.out.println("resize 실패!");
			}
			dispatch(request, response, "calendar.jsp");
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
