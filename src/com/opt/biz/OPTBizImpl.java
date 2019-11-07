package com.opt.biz;

import java.util.List;
import java.util.Map;

import com.opt.dao.OPTDao;
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


public class OPTBizImpl implements OPTBiz {

	private OPTDao dao = new OPTDao();
	
	@Override
	public List<MemberDto> selectList() {
		return dao.selectList();
	}

	@Override
	public MemberDto selectOne(int opt_no_seq) {
		return null;
	}
	
	@Override
	public MemberDto selectOne(String opt_id) {
		return dao.selectOne(opt_id);
	}
	
	@Override
	public int updatePoint(int opt_no_seq, int point){
		return dao.updatePoint(opt_no_seq, point);
	}

	@Override
	public int insert(MemberDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int update(MemberDto dto) {
		return dao.update(dto);
	}

	@Override
	public int delete(int opt_no_seq) {
		return 0;
	}

	@Override
	public MemberDto login(String id, String pw) {
		return dao.login(id, pw);
	}

	@Override
	public int pay_count(int num) {
		return dao.pay_count(num);
	}

	@Override
	public int coupon_count(int num) {
		return dao.coupon_count(num);
	}
	
	@Override
	public List<OrderListDto> orderList(int no){
		return dao.orderList(no);
	}

	// 관리자_유저관리
	@Override
	public int adminUserUpdate(String id, String enabled, String role) {
		return dao.adminUserUpdate(id, enabled, role);
	}
	
	// 관리자_상품관리
	@Override
	public int adminItemUpdate(Map<String, String> update) {
		return dao.adminItemUpdate(update);
	}
	
	// 관리자_결제내역(그래프)
	@Override
	public List<PaymentDto> paymentAllList() {
		return dao.paymentAllList();
	}
	
	// 관리자_유저 페이징
	@Override
	public List<MemberDto> adminUserPaging(int startCount, int endCount) {
		return dao.adminUserPaging(startCount, endCount);
	}
	
	// 관리자_상품 페이징
	@Override
	public List<ItemDto> adminItemPaging(int startCount, int endCount) {
		return dao.adminItemPaging(startCount, endCount);
	}
	
	// 관리자_상품 판매 시작
	@Override
	public int adminItemUnDelete(Map<String, String[]> unDelete) {
		return dao.adminItemUnDelete(unDelete);
	}
	
	// 관리자_상품 삭제
	@Override
	public int adminItemDelete(Map<String, String[]> delete) {
		return dao.adminItemDelete(delete);
	}
	
	@Override
	public List<ItemDto> itemList() {
		return dao.itemList();
	}
	
	@Override
	public List<PaymentDto> paymentList() {
		return dao.paymentList();
	}

	@Override
	public ItemDto itemSelect(int no) {
		return dao.itemSelect(no);
	}

	@Override
	public int itemCount(int no) {
		return dao.itemCount(no);
	}

	@Override
	public List<ItemDto> itemSearch(String keyword, String msg) {
		return dao.itemSearch(keyword, msg);
	}

	@Override
	public List<ItemDto> itemPage(int start, int end) {
		return dao.itemPage(start, end);
	}

	@Override
	public List<ItemDto> itemSearchPage(String keyword, String msg, int start, int end) {
		return dao.itemSearchPage(keyword, msg, start, end);
	}
	
	@Override
	public int insertPayment(PaymentDto PaymentDto) {
		return dao.insertPayment(PaymentDto);
	}
	
	//쿠폰리스트
	@Override
	public List<CouponDto> couponList(int no) {
		return dao.couponList(no);
	}
	//쿠폰 페이징
	@Override
	public List<CouponDto> couponPaging(int opt_no_seq, int start, int end) {
		return dao.couponPaging(opt_no_seq, start, end);
	}
	//사용한 쿠폰 삭제
	@Override
	public int deleteCoupon(int coupon_no_seq) {
		return dao.deleteCoupon(coupon_no_seq);
	}
	
	//장바구니 상품등록
	@Override
	public int insertBasket(BasketDto basketDto) {
		return dao.insertBasket(basketDto);
	}
	
	//장바구니 상품 목록
	@Override
	public List<BasketDto> basketlist(int opt_no) {
		return dao.basketlist(opt_no);
	}
	
	//장바구니 목록삭제
	@Override
	public boolean muldelBasket(String[] seq) {
		return dao.muldelbasket(seq);
	}
	
	//장바구니 수량수정
	@Override
	public boolean updateBasket(List<BasketDto> list) {
		return dao.updateBasket(list);
	}
	
	//장바구니 번호로 상품조회
	@Override
	public BasketDto selectBasket(int basket_no) {
		return dao.selectBasket(basket_no);
	}
	
	//장바구니 번호로 삭제
	@Override
	public int deleteBasket(int basket_no_seq){
		return dao.deleteBasket(basket_no_seq);
	}
	
	//일정관리 일정등록
	@Override
	public int insertCalendar(CalendarDto calendardto) {
		return dao.insertCalendar(calendardto);
	}
	
	//일정 리스트
		@Override
	public List<CalendarDto> Callist(int opt_no_seq) {
		return dao.Callist(opt_no_seq);
	}
	//일정 상세
	@Override
	public CalendarDto CalllistOne(int cal_no_seq) {
		return dao.CalllistOne(cal_no_seq);
	}
	//일정 수정
	@Override
	public int updateCalendar(CalendarDto caldto) {
		// TODO Auto-generated method stub
		return dao.updateCalendar(caldto);
	}
	//일정 삭제
	@Override
	public int deleteCalendar(int cal_no_seq) {
		return dao.deleteCalendar(cal_no_seq);
	}
	//일정 막대 옮기기
	@Override
	public int updateCalendarDrop(CalendarDto caldto) { 
		return dao.updateCalendarDrop(caldto); 
	}
	//일정 막대 사이즈 줄이기/늘리기
	@Override
	public int updateCalendarResize(CalendarDto caldto) {
		return dao.updateCalendarResize(caldto);
	}
	//받은쪽지함 리스트
	@Override
	public List<PostboxDto> recivePostboxList(String id) {
		return dao.recivePostboxList(id);
	}
	
	
	//받은쪽지함 리스트 페이징처리
	@Override
	public List<PostboxDto> recivePostboxListPage(String id, int start, int end) {
		return dao.recivePostboxListPage(id, start, end);
	}
	
	
	//보낸쪽지함 리스트
	@Override
	public List<PostboxDto> sendPostboxList(int opt_no) {
		return dao.sendPostboxList(opt_no);
	}
	
	//보낸쪽지함 리스트 페이징처리
	@Override
	public List<PostboxDto> sendPostboxListPage(int opt_no, int start, int end) {
		return dao.sendPostboxListPage(opt_no, start, end);
	}

	//쪽지 상세페이지
	@Override
	public PostboxDto postboxDetail(int post_no) {

		return dao.postboxDetail(post_no);
	}
	
	//쪽지 확인여부
	@Override
	public int postboxRead(int post_no) {
		
		return dao.postboxRead(post_no);
	}
	
	//받은 쪽지 삭제
	@Override
	public int readDel(int post_no) {

		return dao.reciveDel(post_no);
	}
	
	
	//보낸 쪽지 삭제
	@Override
	public int sendDel(int post_no) {

		return dao.sendDel(post_no);
	}
	
	
	//받은쪽지, 보낸쪽지 삭제된 경우 DB에서 삭제
	@Override
	public int allDel() {
		
		return dao.allDel();
	}

	@Override
	public MemberDto emailChk(String email) {
		return dao.emailChk(email);
	}

	@Override
	public MemberDto findId(String email) {
		return dao.findID(email);
	}

	@Override
	public List<VideoClipDto> selectVideoList() {
		return dao.selectVideoList();
	}

	@Override
	public List<VideoClipDto> videoListPage(int start, int end) {
		return dao.videoListPage(start, end);
	}

	//체크된 보낸쪽지 삭제
	@Override
	public boolean muliteSendDel(String[] post_no) {

		return dao.multiSendDel(post_no);
	}
	
	//체크된 받은쪽지 삭제
	@Override
	public boolean muliteReadDel(String[] post_no) {

		return dao.multiReadDel(post_no);
	}
	
	//쪽지 보내기
	@Override
	public int sendPost(int opt_no, String id, String title, String content) {
		return dao.sendPost(opt_no, id, title, content);
	}
	
	@Override
	public int videoCount(int video_no_seq) {
		return dao.videoCount(video_no_seq);
	}

	@Override
	public VideoClipDto videoSelectOne(int video_no_seq) {
		return dao.videoSelectOne(video_no_seq);
	}


	@Override
	public List<VideoClipDto> searchVideo(String searchoption, String searchtext) {
		return dao.searchVideo(searchoption, searchtext);
	}
	@Override
	public List<VideoClipDto> searchVideoPage(String searchoption, String searchtext, int start, int end) {
		return dao.searchVideoPage(searchoption, searchtext, start, end);
	}

	@Override
	public int insertVideo(VideoClipDto VideoClipDto) {
		return dao.insertVideo(VideoClipDto);
	}

	@Override
	public int deleteVideo(int video_no_seq) {
		return dao.deleteVideo(video_no_seq);
	}
	@Override
	public boolean multiDelVideoComment(String[] seq) {
		return dao.multiDelVideoComment(seq);
	}
	@Override
	public boolean multiDelVideo(String[] seq) {
		return dao.multiDelVideo(seq);
	}
	
	@Override
	public List<VideoClipDto> myVideolist(int no){
		return dao.myVideolist(no);
	}
	
	@Override
	public List<VideoClipDto> myVideoListPage(int no, int start, int end){
		return dao.myVideoListPage(no, start, end);
	}

	@Override
	public int updateVideo(VideoClipDto VideoClipDto) {
		return dao.updateVideo(VideoClipDto);
	}
	
	@Override
	public List<VideoComment> videoCommentList(int no) {
		return dao.videoCommentList(no);
	}

	@Override
	public VideoComment videoCommentselectone(int video_comment_seq) {
		return dao.videoCommentselectone(video_comment_seq);
	}

	@Override
	public int insertVideocomment(VideoComment videocomment) {
		return dao.insertVideocomment(videocomment);
	}

	@Override
	public int videoCommentUpdate(VideoComment videocomment) {
		return dao.videoCommentUpdate(videocomment);
	}

	@Override
	public int videoCommentDelete(int video_comment_seq) {
		return dao.videoCommentDelete(video_comment_seq);
	}

	@Override
	public int deleteVideoComment(int video_no_seq) {
		return dao.deleteVideoComment(video_no_seq);
	}

	// 상품댓글 조회
	@Override
	public List<ItemCommentDto> itemCommentList(int item_num_seq) {
		return dao.itemCommentList(item_num_seq);
	}
	
	// 상품댓글 작성
	@Override
	public int insertItemComment(ItemCommentDto itemCommentDto) {
		return dao.insertItemComment(itemCommentDto);
	}
	
	// 상품댓글 삭제
	@Override
	public int deleteItemComment(int item_comment_no_seq) {
		return dao.deleteItemComment(item_comment_no_seq);
	}
	//고객센터 리스트
	@Override
	public List<CustomerServiceDto> customerList() {
		return dao.customerList();
	}
	//고객센터 리스트 페이징
	@Override
	public List<CustomerServiceDto> customerPaging(int start, int end) {
		return dao.customerPaging(start, end);
	}

	@Override
	public int insertCustomerBoard(CustomerServiceDto customerServiceDto) {
		return dao.insertCustomerBoard(customerServiceDto);
	}

	//관리자 답변 리스트
	@Override
	public List<AdminAnswerDto> adminanswerList() {
		return dao.adminanswerList();
	}
	
	//FAQ 리스트
	@Override
	public List<FaqDto> faqList() {
		return dao.faqList();
	}

	//FAQ 리스트 페이징	
	@Override
	public List<FaqDto> faqListPage(int start, int end) {
		return dao.faqListPage(start, end);
	}

	//FAQ 글쓰기
	@Override
	public int insertFaq(FaqDto faqDto) {
		return dao.insertFaq(faqDto);
	}

	//FAQ 수정하기
	@Override
	public int updateFaq(FaqDto faqDto) {
		return dao.updateFaq(faqDto);
	}
	
	//FAQ 삭제하기
	@Override
	public int deleteFaq(int faq_no_seq) {
		return dao.deleteFaq(faq_no_seq);
	}
	
	//관리자 답변 인서트
	@Override
	public int adminAnswer(AdminAnswerDto adminDto) {
		return dao.adminAnswer(adminDto);
	}

	@Override
	public int adminAnswerDelete(int admin_answer_no_seq) {
		return dao.adminAnswerDelete(admin_answer_no_seq);
	}
	
}
