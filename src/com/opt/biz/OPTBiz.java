package com.opt.biz;

import java.util.List;
import java.util.Map;

import com.opt.dto.AdminAnswerDto;
import com.opt.dto.BasketDto;
import com.opt.dto.CalendarDto;
import com.opt.dto.CouponDto;
import com.opt.dto.CustomerServiceDto;
import com.opt.dto.FaqDto;
import com.opt.dto.ItemCommentDto;
import com.opt.dto.ItemDto;
import com.opt.dto.MemberDto;
import com.opt.dto.OrderListDto;
import com.opt.dto.PaymentDto;
import com.opt.dto.PostboxDto;
import com.opt.dto.VideoClipDto;
import com.opt.dto.VideoComment;

public interface OPTBiz {
	public List<MemberDto> selectList();
	public MemberDto selectOne(int opt_no_seq);
	public MemberDto selectOne(String opt_id);
	public int updatePoint(int opt_no_seq, int point);
	public int insert(MemberDto dto);
	public int update(MemberDto dto);
	public int delete(int opt_no_seq);
	public MemberDto login(String id, String pw);
	public int pay_count(int num);
	public int coupon_count(int num);
	public List<OrderListDto> orderList(int no);
	public List<PaymentDto> paymentList();
	public MemberDto emailChk(String email);	
	public MemberDto findId(String email);

	//비디오
	public List<VideoClipDto> selectVideoList();
	public List<VideoClipDto> videoListPage(int start, int end);
	public int videoCount(int no);
	public VideoClipDto videoSelectOne(int video_no_seq);
	public List<VideoClipDto> searchVideo(String searchoption, String searchtext) ;
	public List<VideoClipDto> searchVideoPage(String searchoption, String searchtext, int start, int end);
	public int insertVideo(VideoClipDto VideoClipDto);
	public int updateVideo(VideoClipDto VideoClipDto);
	public int deleteVideo(int video_no_seq);
	public int deleteVideoComment(int video_no_seq);
	public boolean multiDelVideo(String[] seq);
	public boolean multiDelVideoComment(String[] seq);
	public List<VideoClipDto> myVideolist(int no);
	public List<VideoClipDto> myVideoListPage(int no, int start, int end);

	
	//비디오 댓글
	public List<VideoComment> videoCommentList(int no);
	public VideoComment videoCommentselectone(int no);
	public int insertVideocomment(VideoComment videocomment);
	public int videoCommentUpdate(VideoComment videocomment);
	public int videoCommentDelete(int video_comment_seq);
	
	
	// 관리자_유저관리
	public int adminUserUpdate(String id, String enabled, String role);
	// 관리자_상품관리
	public int adminItemUpdate(Map<String, String> update);
	// 관리자_결제내역(그래프)
	public List<PaymentDto> paymentAllList();
	// 관리자_유저관리 페이징
	public List<MemberDto> adminUserPaging(int startCount, int endCount);
	// 관리자_상품관리 페이징
	public List<ItemDto> adminItemPaging(int startCount, int endCount);
	// 관리자_상품 판매 시작
	public int adminItemUnDelete(Map<String, String[]> unDelete);
	// 관리자_상품 삭제
	public int adminItemDelete(Map<String, String[]> delete);
	
	//상품리스트
	public List<ItemDto> itemList();
	public ItemDto itemSelect(int no);
	public int itemCount(int no);
	public List<ItemDto> itemSearch(String keyword, String msg);
	public List<ItemDto> itemPage(int start, int end);
	public List<ItemDto> itemSearchPage(String keyword, String msg, int start, int end);
	
	//상품댓글
	public List<ItemCommentDto> itemCommentList(int item_num_seq);
	public int insertItemComment(ItemCommentDto itemCommentDto);
	public int deleteItemComment(int item_comment_no_seq);
	
	
	
	//결제상품
	public int insertPayment(PaymentDto PaymentDto);
	
	//쿠폰리스트
	public List<CouponDto> couponList(int no);
	public int deleteCoupon(int coupon_no_seq);
	//쿠폰페이징
	public List<CouponDto> couponPaging(int opt_no_seq , int start , int end);
	//장바구니	
	public int insertBasket(BasketDto basketDto);
	public List<BasketDto> basketlist(int opt_no);
	public boolean muldelBasket(String[] seq);
	public boolean updateBasket(List<BasketDto> list);
	public BasketDto selectBasket(int basket_no);
	public int deleteBasket(int basket_no_seq);

	//일정관리
	public int insertCalendar(CalendarDto calendardto);
	public List<CalendarDto> Callist(int opt_no_seq);
	public CalendarDto CalllistOne(int cal_no_seq);
	public int updateCalendar(CalendarDto caldto);
	public int deleteCalendar(int cal_no_seq);
	public int updateCalendarDrop(CalendarDto caldto);
	public int updateCalendarResize(CalendarDto caldto);
	
	
	//쪽지함
	public List<PostboxDto> recivePostboxList(String id);
	public List<PostboxDto> recivePostboxListPage(String id, int start, int end);
	public List<PostboxDto> sendPostboxList(int opt_no);
	public List<PostboxDto> sendPostboxListPage(int opt_no, int start, int end);
	public PostboxDto postboxDetail(int post_no);
	public int postboxRead(int post_no);
	public int readDel(int post_no);
	public int sendDel(int post_no);
	public int allDel();
	public boolean muliteSendDel(String[] post_no);
	public boolean muliteReadDel(String[] post_no);
	public int sendPost(int opt_no, String id, String title, String content);
	
	//고객센터 리스트
	public List<CustomerServiceDto> customerList();
	//고객센터 페이징
	public List<CustomerServiceDto> customerPaging(int start , int end);
	public int insertCustomerBoard(CustomerServiceDto customerServiceDto);
	
	//관리자 답변 리스트
	public List<AdminAnswerDto> adminanswerList();
	public int adminAnswer(AdminAnswerDto adminDto);
	public int adminAnswerDelete(int admin_answer_no_seq);
	
	//FAQ (자주묻는질문) 게시판
		public List<FaqDto> faqList();
		public List<FaqDto> faqListPage(int start, int end);	
		public int insertFaq(FaqDto faqDto);
		public int updateFaq(FaqDto faqDto);
		public int deleteFaq(int faq_no_seq);
}
