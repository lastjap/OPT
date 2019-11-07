package com.opt.controller;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.opt.biz.OPTBiz;
import com.opt.biz.OPTBizImpl;
import com.opt.dto.BasketDto;
import com.opt.dto.ItemDto;
import com.opt.dto.MemberDto;
import com.opt.dto.PaymentDto;

@WebServlet("/pay.do")
public class OptPayController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String command = request.getParameter("command");
		OPTBiz biz = new OPTBizImpl();
		
		if(command.equals("ready")) {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready"); // url 준비
			HttpURLConnection con = (HttpURLConnection)url.openConnection(); // url로 통신 시작
			con.setRequestMethod("POST"); // POST 방식으로 요청
			con.setRequestProperty("Authorization", "KakaoAK ff69179230343e4b33048124ae42ebd0"); // 요청 헤더 정의
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"); // 요청 헤더 정의
			con.setDoInput(true); // inputstream 으로 응답 헤더와 메시지를 읽겠다
			con.setDoOutput(true); // outputstream 으로 POST 방식의 요청을 하겠다
			
			Map<String, String> params = new HashMap<String, String>(); // 파라미터 설정
			params.put("cid", "TC0ONETIME");
			params.put("partner_order_id", request.getParameter("partner_order_id"));
			params.put("partner_user_id", request.getParameter("partner_user_id"));
			params.put("item_name", request.getParameter("item_name"));
			params.put("quantity", request.getParameter("quantity"));
			params.put("total_amount", request.getParameter("total_amount"));
			params.put("tax_free_amount", request.getParameter("tax_free_amount"));
			params.put("approval_url", request.getParameter("approval_url"));
			params.put("cancel_url", request.getParameter("cancel_url"));
			params.put("fail_url", request.getParameter("fail_url"));
			
			String string_params = new String(); // 보낼 파라미터
			for(Map.Entry<String, String> elem : params.entrySet()) {
				string_params += (elem.getKey() + "=" + elem.getValue() + "&"); // 파라미터 전송 준비
			}
			
			OutputStream out = con.getOutputStream(); // 요청 스트림 생성
			out.write(string_params.getBytes()); // 파라미터를 바이트로 요청
			out.flush(); // 스트림 버퍼 비우기
			out.close(); // 스트림 닫기
			
			// 응답받은 메시지의 길이만큼 버퍼를 생성하여 읽어들인다 (응답 스트림)
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()), con.getContentLength());
			String successUrl = null; // 준비 성공 시 연결할 url
			String tid = null; // 준비 성공시 받을 결제 고유 번호
			
			try { // 응답받은 json 파싱작업
				JSONParser parser = new JSONParser();
				JSONObject res = (JSONObject)parser.parse(in);
				successUrl = (String)res.get("next_redirect_pc_url");
				tid = (String)res.get("tid");
				HttpSession session = request.getSession();
				session.setAttribute("tid", tid);
				session.setAttribute("partner_order_id", request.getParameter("partner_order_id"));
				session.setAttribute("partner_user_id", request.getParameter("partner_user_id"));
				session.setAttribute("coupon_no_seq", request.getParameter("coupon_no_seq"));
				session.setAttribute("addr", request.getParameter("addr"));
				session.setAttribute("memo", request.getParameter("memo"));
				session.setAttribute("point", request.getParameter("point"));
				session.setAttribute("totalPrice", request.getParameter("totalPrice"));
				session.setAttribute("coupon_sale", request.getParameter("coupon_sale"));				
			} catch (ParseException e) {
				e.printStackTrace();
			} finally {
				in.close(); // 응답 스트림 닫기
			}
			response.sendRedirect(successUrl); // 결제창으로 넘어가는 url
		// 결제 승인 통신
		} else if(command.equals("approval")) {
			HttpSession session = request.getSession();
			String cid = "TC0ONETIME";
			String tid = (String)session.getAttribute("tid");
			String pg_token = request.getParameter("pg_token");
			String partner_order_id = (String)session.getAttribute("partner_order_id");
			String partner_user_id = (String)session.getAttribute("partner_user_id");
			URL url = new URL("https://kapi.kakao.com/v1/payment/approve");
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "KakaoAK ff69179230343e4b33048124ae42ebd0");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setDoInput(true);
			con.setDoOutput(true);
			
			Map<String, String> params = new HashMap<String, String>();
			params.put("cid", cid);
			params.put("tid", tid);
			params.put("pg_token", pg_token);
			params.put("partner_order_id", partner_order_id);
			params.put("partner_user_id", partner_user_id);
			
			String string_params = new String();
			for(Map.Entry<String, String> elem : params.entrySet()) {
				string_params += (elem.getKey() + "=" + elem.getValue() + "&");
			}
			
			OutputStream out = con.getOutputStream();
			out.write(string_params.getBytes());
			out.flush();
			out.close();
			
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			JSONParser parser = null;
			JSONObject res = null;
			try {
				parser = new JSONParser();
				res = (JSONObject)parser.parse(in);
				System.out.println("결제 승인 결과 : " + res.toJSONString());
			} catch (ParseException e) {
				e.printStackTrace();
			} finally {
				in.close();
			}
			
			MemberDto memberDto = (MemberDto)session.getAttribute("memdto");
			ItemDto itemDto = (ItemDto)session.getAttribute("itemDto");
			
			PaymentDto payDto = new PaymentDto();
			payDto.setOpt_no_seq(memberDto.getOpt_no_seq());
			payDto.setItem_num(itemDto.getItem_num_seq());
			payDto.setPay_recipient_name(memberDto.getOpt_name());
			payDto.setPay_place((String)session.getAttribute("addr"));
			payDto.setPay_phone(memberDto.getOpt_phone());
			payDto.setPay_memo((String)session.getAttribute("memo"));
			payDto.setPay_count(((Integer)session.getAttribute("ea")).intValue());
			payDto.setPay_total(Integer.parseInt(session.getAttribute("totalPrice").toString()));
			
			int point =  Integer.parseInt(session.getAttribute("point").toString());
			int coupon_no_seq = Integer.parseInt(session.getAttribute("coupon_no_seq").toString());
			biz.updatePoint(memberDto.getOpt_no_seq(), point);
			memberDto.setOpt_point(memberDto.getOpt_point() - point);
			
			biz.deleteCoupon(coupon_no_seq);
			biz.insertPayment(payDto);			
			request.setAttribute("approvalRes", res.toJSONString()); // 응답받은 json 파싱해서 request 속성 설정
			session.setAttribute("memdto", memberDto);
			try {
				dispatch(request, response, "payApprovalRes.jsp"); // 결제 승인 시 응답받은 json을 파싱한걸 가지고 forward
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("basketReady")){
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready"); // url 준비
			HttpURLConnection con = (HttpURLConnection)url.openConnection(); // url로 통신 시작
			con.setRequestMethod("POST"); // POST 방식으로 요청
			con.setRequestProperty("Authorization", "KakaoAK ff69179230343e4b33048124ae42ebd0"); // 요청 헤더 정의
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"); // 요청 헤더 정의
			con.setDoInput(true); // inputstream 으로 응답 헤더와 메시지를 읽겠다
			con.setDoOutput(true); // outputstream 으로 POST 방식의 요청을 하겠다
			
			Map<String, String> params = new HashMap<String, String>(); // 파라미터 설정
			params.put("cid", "TC0ONETIME");
			params.put("partner_order_id", request.getParameter("partner_order_id"));
			params.put("partner_user_id", request.getParameter("partner_user_id"));
			params.put("item_name", request.getParameter("item_name"));
			params.put("quantity", request.getParameter("quantity"));
			params.put("total_amount", request.getParameter("total_amount"));
			params.put("tax_free_amount", request.getParameter("tax_free_amount"));
			params.put("approval_url", request.getParameter("approval_url"));
			params.put("cancel_url", request.getParameter("cancel_url"));
			params.put("fail_url", request.getParameter("fail_url"));
			
			String string_params = new String(); // 보낼 파라미터
			for(Map.Entry<String, String> elem : params.entrySet()) {
				string_params += (elem.getKey() + "=" + elem.getValue() + "&"); // 파라미터 전송 준비
			}
			
			OutputStream out = con.getOutputStream(); // 요청 스트림 생성
			out.write(string_params.getBytes()); // 파라미터를 바이트로 요청
			out.flush(); // 스트림 버퍼 비우기
			out.close(); // 스트림 닫기
			
			// 응답받은 메시지의 길이만큼 버퍼를 생성하여 읽어들인다 (응답 스트림)
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()), con.getContentLength());
			String successUrl = null; // 준비 성공 시 연결할 url
			String tid = null; // 준비 성공시 받을 결제 고유 번호
			
			try { // 응답받은 json 파싱작업
				JSONParser parser = new JSONParser();
				JSONObject res = (JSONObject)parser.parse(in);
				successUrl = (String)res.get("next_redirect_pc_url");
				tid = (String)res.get("tid");
				HttpSession session = request.getSession();
				session.setAttribute("tid", tid);
				session.setAttribute("partner_order_id", request.getParameter("partner_order_id"));
				session.setAttribute("partner_user_id", request.getParameter("partner_user_id"));
				session.setAttribute("coupon_no_seq", request.getParameter("coupon_no_seq"));
				session.setAttribute("addr", request.getParameter("addr"));
				session.setAttribute("memo", request.getParameter("memo"));
				session.setAttribute("point", request.getParameter("point"));
				session.setAttribute("totalPrice", request.getParameter("totalPrice"));
				session.setAttribute("coupon_sale", request.getParameter("coupon_sale"));
			} catch (ParseException e) {
				e.printStackTrace();
			} finally {
				in.close(); // 응답 스트림 닫기
			}
			response.sendRedirect(successUrl); // 결제창으로 넘어가는 url
		}else if(command.equals("basketApproval")){
			HttpSession session = request.getSession();
			String cid = "TC0ONETIME";
			String tid = (String)session.getAttribute("tid");
			String pg_token = request.getParameter("pg_token");
			String partner_order_id = (String)session.getAttribute("partner_order_id");
			String partner_user_id = (String)session.getAttribute("partner_user_id");

			URL url = new URL("https://kapi.kakao.com/v1/payment/approve");
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "KakaoAK ff69179230343e4b33048124ae42ebd0");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setDoInput(true);
			con.setDoOutput(true);
			
			Map<String, String> params = new HashMap<String, String>();
			params.put("cid", cid);
			params.put("tid", tid);
			params.put("pg_token", pg_token);
			params.put("partner_order_id", partner_order_id);
			params.put("partner_user_id", partner_user_id);
			
			String string_params = new String();
			for(Map.Entry<String, String> elem : params.entrySet()) {
				string_params += (elem.getKey() + "=" + elem.getValue() + "&");
			}
			
			OutputStream out = con.getOutputStream();
			out.write(string_params.getBytes());
			out.flush();
			out.close();
			
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			JSONParser parser = null;
			JSONObject res = null;
			try {
				parser = new JSONParser();
				res = (JSONObject)parser.parse(in);
				System.out.println("결제 승인 결과 : " + res.toJSONString());
			} catch (ParseException e) {
				e.printStackTrace();
			} finally {
				in.close();
			}
			
			MemberDto memberDto = (MemberDto)session.getAttribute("memdto");			
			List<BasketDto> basketList = (List)session.getAttribute("basketList");
			for(BasketDto basketDto : basketList){
				ItemDto itemDto = biz.itemSelect(basketDto.getBasket_item_no());
				PaymentDto payDto = new PaymentDto();
				payDto.setOpt_no_seq(memberDto.getOpt_no_seq());				
				payDto.setItem_num(basketDto.getBasket_item_no());
				payDto.setPay_recipient_name(memberDto.getOpt_name());
				payDto.setPay_place((String)session.getAttribute("addr"));
				payDto.setPay_phone(memberDto.getOpt_phone());
				payDto.setPay_memo((String)session.getAttribute("memo"));
				payDto.setPay_count(basketDto.getBasket_item_count());
				payDto.setPay_total(Integer.parseInt(itemDto.getItem_price()) * basketDto.getBasket_item_count());
				
				biz.insertPayment(payDto);
				biz.deleteBasket(basketDto.getBasket_no_seq());
				System.out.println(basketDto.getBasket_no_seq());
			}
			int point =  Integer.parseInt(session.getAttribute("point").toString());
			int coupon_no_seq = Integer.parseInt(session.getAttribute("coupon_no_seq").toString());
			biz.updatePoint(memberDto.getOpt_no_seq(), point);
			memberDto.setOpt_point(memberDto.getOpt_point() - point);			
			biz.deleteCoupon(coupon_no_seq);
						
			request.setAttribute("approvalRes", res.toJSONString()); // 응답받은 json 파싱해서 request 속성 설정
			session.setAttribute("memdto", memberDto);
			
			try {
				dispatch(request, response, "basketPayApprovalRes.jsp"); // 결제 승인 시 응답받은 json을 파싱한걸 가지고 forward
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void dispatch(HttpServletRequest request, HttpServletResponse response, String url) throws Exception {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	
}

