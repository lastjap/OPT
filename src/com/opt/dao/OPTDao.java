package com.opt.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession; 

import com.opt.dto.ItemDto;
import com.opt.dto.AdminAnswerDto;
import com.opt.dto.BasketDto;
import com.opt.dto.CalendarDto;
import com.opt.dto.CouponDto;
import com.opt.dto.CustomerServiceDto;
import com.opt.dto.FaqDto;
import com.opt.dto.ItemCommentDto;
import com.opt.dto.MemberDto;
import com.opt.dto.OrderListDto;
import com.opt.dto.PaymentDto;
import com.opt.dto.PostboxDto;
import com.opt.dto.VideoClipDto;
import com.opt.dto.VideoComment;

public class OPTDao extends SqlMapConfig {

	private String namespace = "optmapper.";
	
	// 로그인
	public MemberDto login(String id, String pw) {
		SqlSession session = null;
		MemberDto res = new MemberDto();
		
		HashMap<String, Object> login = new HashMap<String, Object>();
		login.put("id", id);
		login.put("pw", pw);
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.selectOne("LoginMapper.login", login);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	// 회원가입
	public int insert(MemberDto dto) {
		SqlSession session = null;
		int result = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			result = session.insert("LoginMapper.register", dto);
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

		return result;
	}
	
	public List<MemberDto> selectList() {
		SqlSession session = null;
		List<MemberDto> list = new ArrayList<MemberDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList(namespace + "selectList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	// 회원정보 조회
	public MemberDto selectOne(String opt_id) {
		SqlSession session = null;
		MemberDto dto = new MemberDto();
		try {
			session = getsqlSessionFactory().openSession(false);
			dto = session.selectOne(namespace + "idChk", opt_id);						
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return dto;
	}
	
	// 회원정보 수정
	public int update(MemberDto dto) {
		SqlSession session = null;
		int result = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			result = session.update("LoginMapper.updateUser", dto);
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

		return result;
	}
	
	// ID 찾기
	public MemberDto findID(String email) {
		SqlSession session = null;
		MemberDto res = new MemberDto();
		session = getsqlSessionFactory().openSession(false);
		res = session.selectOne("LoginMapper.findId", email);

		return res;
	}
	
	public int updatePoint(int opt_no_seq, int point) {
		SqlSession session = null;
		int res = 0;
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("opt_no_seq", opt_no_seq);
		map.put("point", point);
		try {			
			session = getsqlSessionFactory().openSession(false);
			res = session.update(namespace+"updatePoint", map);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	
	public MemberDto emailChk(String email) {
		SqlSession session = null;
		MemberDto res = new MemberDto();

		session = getsqlSessionFactory().openSession(false);
		res = session.selectOne("LoginMapper.emailChk", email);

		return res;
	}
	
	// 회원의 결제내역 조회
	public int pay_count(int num) {
		SqlSession session = null;
		int count = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			count = session.selectOne("PayMapper.pay_count",num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}
	
	// 쿠폰 개수
	public int coupon_count(int num) {
		SqlSession session = null;
		int count = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			count = session.selectOne("CouponMapper.coupon_count", num);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}
	
	// 주문 리스트
	public List<OrderListDto> orderList(int no){
		SqlSession session = null;
		List<OrderListDto> list = new ArrayList<OrderListDto>();
		try {
			session = getsqlSessionFactory().openSession();
			list = session.selectList("OrderMapper.order_list", no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	// 상품 리스트
	public List<ItemDto> itemList() {
		SqlSession session = null;
		List<ItemDto> list = new ArrayList<ItemDto>();
		session = getsqlSessionFactory().openSession(false);
		list = session.selectList("ItemMapper.itemList");
		return list;
	}
	
	// 결제 리스트
	public List<PaymentDto> paymentList() {
		SqlSession session = null;
		List<PaymentDto> list = new ArrayList<PaymentDto>();
		session = getsqlSessionFactory().openSession(false);
		list = session.selectList("PayMapper.paymentList");
		session.close();
		return list;
	}

	// 관리자_유저관리
	public int adminUserUpdate(String id, String enabled, String role) {
		SqlSession session = null;
		session = getsqlSessionFactory().openSession(false);
		Map<String, Object> update = new HashMap<String, Object>();
		update.put("id", id);
		update.put("enabled", enabled);
		update.put("role", role);
		int res = session.update("AdminMapper.adminUserUpdate", update);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	
	// 관리자_상품관리
	public int adminItemUpdate(Map<String, String> update) {
		SqlSession session = null;
		session = getsqlSessionFactory().openSession(false);
		int res = session.update("AdminMapper.adminItemUpdate", update);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	
	// 관리자_결제리스트
	public List<PaymentDto> paymentAllList() {
		SqlSession session = null;
		session = getsqlSessionFactory().openSession(false);
		List<PaymentDto> list = session.selectList("PayMapper.paymentAllList");
		session.close();
		return list;
	}
	
	// 관리자_유저관리 페이징
	public List<MemberDto> adminUserPaging(int startCount, int endCount) {
		SqlSession session = null;
		session = getsqlSessionFactory().openSession(false);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("startCount", startCount);
		map.put("endCount", endCount);
		List<MemberDto> list = session.selectList("AdminMapper.userPaging", map);
		session.close();
		return list;
	}
	
	// 관리자_상품관리 페이징
	public List<ItemDto> adminItemPaging(int startCount, int endCount) {
		SqlSession session = null;
		session = getsqlSessionFactory().openSession(false);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("startCount", startCount);
		map.put("endCount", endCount);
		List<ItemDto> list = session.selectList("AdminMapper.itemPaging", map);
		session.close();
		return list;
	}
		
	// 관리자_상품 판매 시작
		public int adminItemUnDelete(Map<String, String[]> unDelete) {
			SqlSession session = null;
			session = getsqlSessionFactory().openSession(false);
			int res = session.update("AdminMapper.itemUnDelete", unDelete);
			if(res > 0) {
				session.commit();
			}
			session.close();
			return res;
		}
	
	// 관리자_상품 판매 중지
	public int adminItemDelete(Map<String, String[]> delete) {
		SqlSession session = null;
		session = getsqlSessionFactory().openSession(false);
		int res = session.update("AdminMapper.itemDelete", delete);
		if(res > 0) {
			session.commit();
		}
		session.close();
		return res;
	}
	
	// 선택한 상품 정보 출력
	public ItemDto itemSelect(int no){
		SqlSession session = null;
		ItemDto dto = new ItemDto();
		try {
			session = getsqlSessionFactory().openSession(false);
			dto = session.selectOne("ItemMapper.itemSelect", no);
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			session.close();
		}
		return dto;
	}
	
	// 상품 조회수 하나씩 올림
	public int itemCount(int no){
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("ItemMapper.itemCount", no);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	// 상품 검색 리스트
	public List<ItemDto> itemSearch(String keyword, String msg) {		
		SqlSession session = null;
		List<ItemDto> list = new ArrayList<ItemDto>();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("msg", msg);
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("ItemMapper.searchItem", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	// 상품 검색리스트 페이징 처리
	public List<ItemDto> itemSearchPage(String keyword, String msg, int start, int end) {
		SqlSession session = null;
		List<ItemDto> list = new ArrayList<ItemDto>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("msg", msg);
		map.put("start", start);
		map.put("end", end);
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("ItemMapper.searchItemPage", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	// 상품 리스트 페이징처리
	public List<ItemDto> itemPage(int start, int end) {
		SqlSession session = null;
		List<ItemDto> list = new ArrayList<ItemDto>();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("ItemMapper.itemPage", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	
	
	// 결제 내역 db 추가
	public int insertPayment(PaymentDto PaymentDto) {
		
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("PayMapper.insertPayment", PaymentDto);
			
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	
	
	// 보유 쿠폰 리스트
	public List<CouponDto> couponList(int no) {
		SqlSession session = null;
		List<CouponDto> list = new ArrayList<CouponDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("CouponMapper.couponList", no);
		} catch (Exception e) {
			e.printStackTrace();
		}	finally {
			session.close();
		}
		return list;
	}
	
	// 사용한 쿠폰 삭제
	public int deleteCoupon(int coupon_no_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("CouponMapper.deleteCoupon", coupon_no_seq);
			
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	finally {
			session.close();
		}
		return res;	
	}
	
	//내 쿠폰함 페이징
	public List<CouponDto> couponPaging(int opt_no_seq, int start, int end) {
		SqlSession session = null;
		List<CouponDto> list = new ArrayList<CouponDto>();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("opt_no_seq",opt_no_seq);
		map.put("start", start);
		map.put("end", end);
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("CouponMapper.CouponPaging", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	// 장바구니에 상품 추가
	public int insertBasket(BasketDto basketDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("BasketMapper.insertBasket", basketDto);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			session.close();
		}

		return res;
	}
	
	//일정 등록
	public int insertCalendar(CalendarDto calendardto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("CalMapper.insertCal" , calendardto);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}
	
	//장바구니 목록
	public List<BasketDto> basketlist(int opt_no){
		SqlSession session=null;
		List<BasketDto> list=new ArrayList<BasketDto>();
		
		try {
			session=getsqlSessionFactory().openSession(false);
			list=session.selectList("BasketMapper.basketlist", opt_no);
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			session.close();
			
		}
		return list;
		
	}
	
	//장바구니 멀티삭제
	public boolean muldelbasket(String[] seq) {
		int count=0;
		Map<String , String[]> map=new HashMap<String, String[]>();
		map.put("seqs", seq);
		
		SqlSession session=null;
		try {
			session=getsqlSessionFactory().openSession(false);
			count=session.delete("BasketMapper.basketmuldel",map);
			if(count==seq.length) {
				session.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return count==seq.length?true:false;
	}
	
	//장바구니 수량 수정
	public boolean updateBasket(List<BasketDto> list) {
		int cnt = 0;
		SqlSession session=null;
		try {
			session=getsqlSessionFactory().openSession(false);
			cnt=session.update("BasketMapper.updateBasket", list);		
			if(cnt==-1) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {			
			e.printStackTrace();
		}finally {
			session.close();
		}		
		return cnt==-1?true:false;
	}
	
	//장바구니 번호로 조회
	public BasketDto selectBasket(int basket_no) {
		SqlSession session = null;
		BasketDto dto = new BasketDto();
		try {
			session = getsqlSessionFactory().openSession(false);
			dto = session.selectOne("BasketMapper.selectBasket" , basket_no);			
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return dto;
	}
	
	//장바구니 번호로 삭제하기
	public int deleteBasket(int basket_no_seq){
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("BasketMapper.deleteBasket", basket_no_seq);
			if(res>0){
				session.commit();
			}else{
				session.rollback();
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		return res;	
	}
	
	//일정 리스트
	public List<CalendarDto> Callist(int opt_no_seq) {
			
		SqlSession session = null;
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("CalMapper.calselectList", opt_no_seq);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
			
			
			return list;
		}	
	//일정 디테일
	public CalendarDto CalllistOne(int cal_no_seq) {
		
		SqlSession session = null;
		CalendarDto Caldto = new CalendarDto();
		
		try {
			session = getsqlSessionFactory().openSession(false);
			Caldto = session.selectOne("CalMapper.calselectone", cal_no_seq);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return Caldto;
	}	
	//일정 수정
	public int updateCalendar(CalendarDto caldto) {
		
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("CalMapper.updateCal" , caldto);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}
	
	//일정 삭제
	public int deleteCalendar(int cal_no_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("CalMapper.deleteCal" , cal_no_seq);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}
	//일정 막대 옮기기
	
	public int updateCalendarDrop(CalendarDto caldto) {
		SqlSession session = null; 
		int res = 0;
		try { 
			session = getsqlSessionFactory().openSession(false);
			res = session.update("CalMapper.updateDrop" , caldto); 
			if(res > 0) {
				session.commit(); 
			}else { 
				session.rollback();
			} 
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			session.close(); 
		}
	 
	  return res;
	  }
	//일정 막대 사이즈 줄이기/늘리기
	public int updateCalendarResize(CalendarDto caldto) {
		SqlSession session = null; 
		int res = 0;
		try { 
			session = getsqlSessionFactory().openSession(false);
			res = session.update("CalMapper.updateResize" , caldto); 
			if(res > 0) {
				session.commit(); 
			}else { 
				session.rollback();
			} 
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			session.close(); 
		}
	 
	  return res;
	}
	 
	// 받은 쪽지함 리스트
	public List<PostboxDto> recivePostboxList(String id) {
		SqlSession session = null;
		List<PostboxDto> list = new ArrayList<PostboxDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("PostboxMapper.postboxReciveList", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();			
		}
		
		return list;
	}
	
	// 받은 쪽지함 리스트 페이징처리
	public List<PostboxDto> recivePostboxListPage(String id, int start, int end) {
		SqlSession session = null;
		List<PostboxDto> list = new ArrayList<PostboxDto>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);		
		map.put("start", start);
		map.put("end", end);
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("PostboxMapper.postboxReciveListPage", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	// 보낸 쪽지함 리스트
	public List<PostboxDto> sendPostboxList(int opt_no) {
		SqlSession session = null;
		List<PostboxDto> list = new ArrayList<PostboxDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("PostboxMapper.sendPostboxList", opt_no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();			
		}
		return list;
	}
	
	// 보낸 쪽지함 리스트 페이징처리
	public List<PostboxDto> sendPostboxListPage(int opt_no, int start, int end) {
		SqlSession session = null;
		List<PostboxDto> list = new ArrayList<PostboxDto>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("opt_no", opt_no);		
		map.put("start", start);
		map.put("end", end);
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("PostboxMapper.sendPostboxListPage", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
public PostboxDto postboxDetail(int post_no) {
		SqlSession session = null;
		PostboxDto dto = new PostboxDto();
		try {
			session = getsqlSessionFactory().openSession(false);
			dto = session.selectOne("PostboxMapper.postboxDetail", post_no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return dto;
	}
	
	// 쪽지 확인여부
	public int postboxRead(int post_no) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("PostboxMapper.postboxRead", post_no);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	// 받은 쪽지 삭제
	public int reciveDel(int post_no) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("PostboxMapper.readDel", post_no);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	//받은쪽지, 보낸쪽지 삭제된 경우 DB에서 삭제
	public int allDel() {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("PostboxMapper.allDel");
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	public List<VideoClipDto> selectVideoList() {
		SqlSession session = null;
		List<VideoClipDto> list = new ArrayList<VideoClipDto>();
		session = getsqlSessionFactory().openSession();
		list = session.selectList("VideoMapper.videolist");
		return list;
	}

	public List<VideoClipDto> videoListPage(int start, int end) {
		SqlSession session = null;
		List<VideoClipDto> list = new ArrayList<VideoClipDto>();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		session = getsqlSessionFactory().openSession();
		list = session.selectList("VideoMapper.videoPage", map);
		return list;
	}

	public List<VideoClipDto> searchVideo(String searchoption, String searchtext) {
		SqlSession session = null;
		List<VideoClipDto> list = new ArrayList<VideoClipDto>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("searchoption", searchoption);
		map.put("searchtext", searchtext);
		session = getsqlSessionFactory().openSession();
		list = session.selectList("VideoMapper.searchVideo", map);
		return list;
	}

	public List<VideoClipDto> searchVideoPage(String searchoption, String searchtext, int start, int end) {
		SqlSession session = null;
		List<VideoClipDto> list = new ArrayList<VideoClipDto>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("searchoption", searchoption);
		map.put("searchtext", searchtext);
		map.put("start", start);
		map.put("end", end);
		session = getsqlSessionFactory().openSession();
		list = session.selectList("VideoMapper.searchVideoPage", map);
		return list;
	}

	public int videoCount(int video_no_seq) {
		int res = 0;
		SqlSession session = null;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("VideoMapper.videoCount", video_no_seq);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	// 보낸 쪽지 삭제
	public int sendDel(int post_no) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("PostboxMapper.sendDel", post_no);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	public int insertVideo(VideoClipDto VideoClipDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("VideoMapper.insertVideo", VideoClipDto);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	//체크된 보낸 쪽지 삭제
	public boolean multiSendDel(String[] post_no) {
		int count = 0;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("post_no", post_no);
		SqlSession session = null;
		try {
			session = getsqlSessionFactory().openSession(false);
			count = session.update("PostboxMapper.multiSendDel", map);
			if(count == post_no.length) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return (count==post_no.length)?true:false;
	}
	
	//체크된 받은 쪽지 삭제
	public boolean multiReadDel(String[] post_no) {
		int count = 0;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("post_no", post_no);
		SqlSession session = null;
		try {
			session = getsqlSessionFactory().openSession(false);
			count = session.update("PostboxMapper.multiReadDel", map);
				
			if(count == post_no.length) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return (count==post_no.length)?true:false;
	}
	
	//쪽지 보내기
	public int sendPost(int opt_no, String id, String title, String content) {
		int res = 0;
		SqlSession session = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("opt_no", opt_no);
		map.put("id", id);
		map.put("title", title);
		map.put("content", content);		
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("PostboxMapper.sendPost", map);
			if(res > 0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}			
		return res;
	}
	
	public int updateVideo(VideoClipDto VideoClipDto) {
		SqlSession session = null;
		int result = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			result = session.update("VideoMapper.updateVideo", VideoClipDto);
			System.out.println(result);

			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return result;
	}
	public int deleteVideoComment(int video_no_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("VideoMapper.deleteVideoComment", video_no_seq);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	
	

	public int deleteVideo(int video_no_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("VideoMapper.deleteVideo", video_no_seq);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	public boolean multiDelVideoComment(String[] seq) {
		SqlSession session = null;
		int cnt = 0;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq", seq);
		try {
			session = getsqlSessionFactory().openSession(false);
			cnt = session.delete("VideoMapper.multiDelVideoComment", map);
			if (cnt == seq.length) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

		return cnt == seq.length ? true : false;
	}
	

	public boolean multiDelVideo(String[] seq) {
		SqlSession session = null;
		int cnt = 0;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq", seq);
		try {
			session = getsqlSessionFactory().openSession(false);
			cnt = session.delete("VideoMapper.multiDel", map);
			if (cnt == seq.length) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

		return cnt == seq.length ? true : false;
	}

	public VideoClipDto videoSelectOne(int video_no_seq) {
		SqlSession session = null;
		VideoClipDto dto = new VideoClipDto();
		session = getsqlSessionFactory().openSession();
		dto = session.selectOne("VideoMapper.videoSelectOne", video_no_seq);

		return dto;
	}

	public List<VideoComment> videoCommentList(int no) {
		SqlSession session = null;
		List<VideoComment> list = new ArrayList<VideoComment>();
		session = getsqlSessionFactory().openSession();
		list = session.selectList("VideoMapper.videoCommentList", no);

		return list;
	}

	public VideoComment videoCommentselectone(int video_comment_seq) {
		SqlSession session = null;
		VideoComment dto = null;
		session = getsqlSessionFactory().openSession(false);
		dto = session.selectOne("VideoMapper.videoCommentSelectone", video_comment_seq);
		return dto;
	}

	public int insertVideocomment(VideoComment videocomment) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("VideoMapper.videoCommentInsert", videocomment);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	public int videoCommentUpdate(VideoComment VideoCommentDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(true);
			res = session.update("VideoMapper.videoCommentUpdate", VideoCommentDto);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	public int videoCommentDelete(int video_comment_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("VideoMapper.videoCommentDelete", video_comment_seq);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	public List<ItemCommentDto> itemCommentList(int item_num_seq) {
		SqlSession session = null;
		List<ItemCommentDto> list = new ArrayList<ItemCommentDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("ItemCommentMapper.itemCommentList", item_num_seq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	public int insertItemComment(ItemCommentDto itemCommentDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("ItemCommentMapper.insertItemComment", itemCommentDto);
			if(res>0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	public int deleteItemComment(int item_comment_no_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("ItemCommentMapper.deleteItemComment", item_comment_no_seq);
			if(res>0) {
				session.commit();
			}else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	//고객센터 리스트
	public List<CustomerServiceDto> customerList() {
		SqlSession session = null;
		List<CustomerServiceDto> list = new ArrayList<CustomerServiceDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("CustomerMapper.customerList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	//고객센터 리스트 페이징
	public List<CustomerServiceDto> customerPaging(int start, int end) {
		SqlSession session = null;
		List<CustomerServiceDto> list = new ArrayList<CustomerServiceDto>();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("CustomerMapper.customerPaging", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	public List<VideoClipDto> myVideolist(int no){		
		SqlSession session = null;
		List<VideoClipDto> list = new ArrayList<VideoClipDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("VideoMapper.myVideolist", no);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return list;
		
	}
	
	public List<VideoClipDto> myVideoListPage(int no, int start, int end){
		SqlSession session = null;
		List<VideoClipDto> list = new ArrayList<VideoClipDto>();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("no", no);
		map.put("start", start);
		map.put("end", end);
		
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("VideoMapper.myVideoListPage", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return list;
	}
	

	public int insertCustomerBoard(CustomerServiceDto customerServiceDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("CustomerMapper.insertCustomerBoard", customerServiceDto);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	//관리자 답변 리스트
	public List<AdminAnswerDto> adminanswerList() {
		SqlSession session = null;
		List<AdminAnswerDto> list = new ArrayList<AdminAnswerDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("AdminAnswerMapper.adminanswerList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	//FAQ 리스트
	public List<FaqDto> faqList() {
		SqlSession session = null;
		List<FaqDto> list = new ArrayList<FaqDto>();
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("CustomerMapper.faqList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	//FAQ 리스트 페이징	
	public List<FaqDto> faqListPage(int start, int end) {
		SqlSession session = null;
		List<FaqDto> list = new ArrayList<FaqDto>();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end",end);
		
		try {
			session = getsqlSessionFactory().openSession(false);
			list = session.selectList("CustomerMapper.faqListPage", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	//FAQ 글쓰기
	public int insertFaq(FaqDto faqDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("CustomerMapper.insertFaq", faqDto);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	//FAQ 수정하기
	public int updateFaq(FaqDto faqDto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.update("CustomerMapper.updateFaq", faqDto);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	//FAQ 삭제하기
	public int deleteFaq(int faq_no_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("CustomerMapper.updateFaq", faq_no_seq);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	
	//관리자 답변 인서트
	public int adminAnswer(AdminAnswerDto adminDto) {
		
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.insert("AdminAnswerMapper.adminAnswerInsert", adminDto);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
	public int adminAnswerDelete(int admin_answer_no_seq) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getsqlSessionFactory().openSession(false);
			res = session.delete("AdminAnswerMapper.adminAnswerDelete", admin_answer_no_seq);
			if (res > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	
}
