package com.opt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
import com.opt.dto.MemberDto;
import com.opt.dto.PaymentDto;

import util.Gmail;


@WebServlet("/login.do")
public class OptLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8"); 
		
		String command = request.getParameter("command");
		System.out.println("[ login.do?" + command + " ]");
		OPTBiz biz = new OPTBizImpl();
		PrintWriter out = response.getWriter();
		
		// 로그아웃
		if(command.equals("logout")) {
			HttpSession session = request.getSession();
			session.removeAttribute("memdto");
			dispatch(request, response, "index.jsp");
		// 로그인
		} else if(command.equals("login")) {
			String id = request.getParameter("id"); // 입력 아디디
			String pw = request.getParameter("pw"); // 입력 패스워드

			String hidden_chk = request.getParameter("hidden_chk");	//체크시 on 안되면 null
			MemberDto login = biz.login(id, pw); // 로그인 시도
			
			// 로그인 안됨, 아이디, 비밀번호 미입력
			if(login == null && id.equals("") && pw.equals("")) {
				response.sendRedirect("opt.do?command=login");
			// 아이디, 비밀번호 입력했으나 로그인 실패
			} else if(login == null && !id.equals("") && !pw.equals("")) {
				dispatch(request, response, "login.jsp?res=fail");
			// 로그인 성공, 계정이 활성화 된 상태
			} else if(login.getOpt_enabled().equals("Y")){
				HttpSession session = request.getSession();
				session.setAttribute("memdto", login);
				session.setAttribute("id", login.getOpt_id());
				session.setAttribute("opt_no", login.getOpt_no_seq());
				session.setMaxInactiveInterval(3600);
				// 관리자 계정일 때 관리자페이지로 이동
				if(login.getOpt_role().equals("admin")) {
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
				// 유저 계정일 때 유저페이지로 이동
				} else if(login.getOpt_role().equals("user")) {
					if(hidden_chk == null) {
						Cookie c = new Cookie("idSave", "");
						c.setMaxAge(60*60*24);
						response.addCookie(c);
					} else {
						Cookie c = new Cookie("idSave", id);
						c.setMaxAge(60*60*24); // 쿠키 유효기간을 설정한다. 초단위 : 60*60*24= 1일
						response.addCookie(c); // 응답헤더에 쿠키를 추가한다.
					}
					// Flag
					// 0 : index
					// 1 : mypage
					// 2 : payment
					// 3 : itemdetail
					
					int Flag = Integer.parseInt(request.getParameter("Flag"));
					if(Flag == 0) {
						dispatch(request, response, "index.jsp?");
					} else if(Flag == 1) {
						response.sendRedirect("opt.do?command=mypage");
					} else if(Flag == 2) {
						int itemNo = Integer.parseInt(request.getParameter("no"));
						int itemEa = Integer.parseInt(request.getParameter("ea"));
						dispatch(request, response, "item.do?command=payment&Flag=2&no="+itemNo+"&ea="+itemEa);
					} else if(Flag == 3) {
						int itemNo = Integer.parseInt(request.getParameter("itemNo"));
						int page = Integer.parseInt(request.getParameter("itemPage"));
						dispatch(request, response, "item.do?command=itemdetail&Flag=3&no="+itemNo+"&page="+page);
					}
					
					
					//회원정보수정
					if(command.equals("registchange")) {
						dispatch(request, response, "regist_change_enter.jsp");
					}
				}
				
			} else if(login.getOpt_enabled().equals("N")){
				dispatch(request, response, "login.jsp?res=fail");
			
			}
			
			
			
		}else if(command.equals("userIds")) {
			List<MemberDto> list = new ArrayList<MemberDto>();
			list = biz.selectList();
			JSONArray jArray = new JSONArray();
			JSONObject JObject = new JSONObject();
			try {
				for (int i = 0; i < list.size(); i++) {
					jArray.add(list.get(i).getOpt_id());
				}
				JObject.put("id", jArray);
			} catch (Exception e) {
				e.printStackTrace();
			}
			out.print(JObject);
		}else if(command.equals("ChkEmail")) {
			String email = request.getParameter("email");
			MemberDto dto = biz.emailChk(email);
			if (dto != null) {
				out.println(dto.getOpt_email());
			}
		}else if(command.equals("sendEmail")) {
			String email = request.getParameter("email");

			String ran = "";
			for (int i = 0; i < 4; i++) {
				ran += (int) (Math.random() * 10);
			}

			String from = "optservicecenter@gmail.com";
			String to = email;
			String subject = "OPT 메일 인증입니다.";
			String content = "인증번호 : " + ran;

			out.print(ran);

			Properties prop = new Properties();
			prop.put("mail.smtp.user", from);
			prop.put("mail.smtp.host", "smtp.googlemail.com");
			prop.put("mail.smtp.port", "465");
			prop.put("mail.smtp.starttls.enable", "true");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.debug", "true");
			prop.put("mail.smtp.socketFactory.port", "465");
			prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			prop.put("mail.smtp.socketFactory.fallback", "false");

			try {
				Authenticator auth = new Gmail();
				Session ses = Session.getInstance(prop, auth);
				ses.setDebug(true);
				MimeMessage msg = new MimeMessage(ses);
				msg.setSubject(subject);
				Address fromAddr = new InternetAddress(from);
				msg.setFrom(fromAddr);
				Address toAddr = new InternetAddress(to);
				msg.addRecipient(Message.RecipientType.TO, toAddr);
				msg.setContent(content, "text/html; charset=UTF-8");
				Transport.send(msg);
			} catch (MessagingException e) {
				e.printStackTrace();
			}
		}else if(command.equals("register")) {
			String opt_id = request.getParameter("opt_id");
			String opt_pw = request.getParameter("opt_pw");
			String opt_name = request.getParameter("opt_name");
			String opt_birth = request.getParameter("opt_birth");
			String opt_phone = request.getParameter("opt_phone");
			String postcode = request.getParameter("postcode");
			String roadAddress = request.getParameter("roadAddress");
			String detailAddress = request.getParameter("opt_addr");
			String opt_addr = postcode + roadAddress + detailAddress;
			String email1 = request.getParameter("opt_email");
			String email2 = request.getParameter("opt_email_addr");
			String opt_email = email1 + email2;
			String opt_gender = request.getParameter("opt_gender");

			MemberDto dto = new MemberDto();
			dto.setOpt_id(opt_id);
			dto.setOpt_pw(opt_pw);
			dto.setOpt_name(opt_name);
			dto.setOpt_birth(opt_birth);
			dto.setOpt_addr(opt_addr);
			dto.setOpt_phone(opt_phone);
			dto.setOpt_email(opt_email);
			dto.setOpt_gender(opt_gender);

			int res = biz.insert(dto);
			if(res > 0) {
				System.out.println("회원가입 성공");
			}else {
				System.out.println("회원가입 실패");
			}
			
			response.sendRedirect("index.jsp");
			
		}else if(command.equals("updateUser")) {
			String opt_id = request.getParameter("opt_id");
			String opt_pw = request.getParameter("opt_pw");
			String opt_name = request.getParameter("opt_name");
			String opt_birth = request.getParameter("opt_birth");
			String opt_phone = request.getParameter("opt_phone");
			String postcode = request.getParameter("postcode");
			String roadAddress = request.getParameter("roadAddress");
			String detailAddress = request.getParameter("opt_addr");
			String opt_addr = postcode + roadAddress + detailAddress;
			String opt_email = request.getParameter("opt_email");
			String opt_gender = request.getParameter("opt_gender");

			MemberDto dto = new MemberDto();
			dto.setOpt_id(opt_id);
			dto.setOpt_pw(opt_pw);
			dto.setOpt_name(opt_name);
			dto.setOpt_birth(opt_birth);
			dto.setOpt_addr(opt_addr);
			dto.setOpt_phone(opt_phone);
			dto.setOpt_email(opt_email);
			dto.setOpt_gender(opt_gender);

			int res = biz.update(dto);
			if(res > 0) {
				out.print("<sctipt>alert('회원정보가 수정되었습니다')</script>");
				System.out.println("회원정보수정 성공");
			}else {
				System.out.println("회원정보수정 실패");
				out.print("<sctipt>alert('회원정보수정이 실패되었습니다')</script>");
			}
			
		}else if(command.equals("snslogin")) {
			String opt_id = request.getParameter("opt_id");
			String email = request.getParameter("opt_email");
			String Flag = request.getParameter("Flag");
			MemberDto dto = biz.findId(email);
			if (dto != null && dto.getOpt_email().equals(email) ) {
					String id = dto.getOpt_id();
					String pw = dto.getOpt_pw();
					String url = "login.do?command=login&id=" + id + "&pw=" + pw + "&flag="+Flag;
					dispatch(request, response, url);
			}else {
				String opt_pw = opt_id;
				String opt_name = "sns";
				String opt_birth = "sns";
				String opt_phone = "sns";
				String opt_addr = "sns";
				String opt_gender = "sns";

				MemberDto snsDto = new MemberDto();
				snsDto.setOpt_id(opt_id);
				snsDto.setOpt_pw(opt_pw);
				snsDto.setOpt_name(opt_name);
				snsDto.setOpt_birth(opt_birth);
				snsDto.setOpt_addr(opt_addr);
				snsDto.setOpt_phone(opt_phone);
				snsDto.setOpt_email(email);
				snsDto.setOpt_gender(opt_gender);

				int res = biz.insert(snsDto);
				if (res > 0) {
					System.out.println("회원가입 성공");
					response.sendRedirect("index.jsp");
				} else {
					System.out.println("회원가입 실패");
				}
			}
		}else if(command.equals("findId")) {
			String email = request.getParameter("email");
			MemberDto dto = biz.findId(email);

			String id = dto.getOpt_id();
			out.println(id);
			
		}else if(command.equals("findPassword")) {

			String email = request.getParameter("email");
			MemberDto dto = biz.findId(email);
			String pw = dto.getOpt_pw();

			String from = "kode15333@gmail.com";
			String to = email;
			String subject = "OPT 비밀번호입니다.";
			String content = "비밀번호 : " + pw;

			Properties prop = new Properties();
			prop.put("mail.smtp.user", from);
			prop.put("mail.smtp.host", "smtp.googlemail.com");
			prop.put("mail.smtp.port", "465");
			prop.put("mail.smtp.starttls.enable", "true");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.debug", "true");
			prop.put("mail.smtp.socketFactory.port", "465");
			prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			prop.put("mail.smtp.socketFactory.fallback", "false");

			try {

				Authenticator auth = new Gmail();
				Session ses = Session.getInstance(prop, auth);
				ses.setDebug(true);
				MimeMessage msg = new MimeMessage(ses);
				msg.setSubject(subject);
				Address fromAddr = new InternetAddress(from);
				msg.setFrom(fromAddr);
				Address toAddr = new InternetAddress(to);
				msg.addRecipient(Message.RecipientType.TO, toAddr);
				msg.setContent(content, "text/html; charset=UTF-8");
				Transport.send(msg);

			} catch (MessagingException e) {
				e.printStackTrace();
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
