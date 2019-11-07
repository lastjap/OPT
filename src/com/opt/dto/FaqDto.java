package com.opt.dto;

import java.sql.Date;

public class FaqDto {

	private int faq_no_seq;
	private String faq_title;
	private String faq_content;
	private Date faq_regdate;
	private String faq_id;
	private int r;
	
	
	
	public String getFaq_id() {
		return faq_id;
	}
	public void setFaq_id(String faq_id) {
		this.faq_id = faq_id;
	}
	public int getFaq_no_seq() {
		return faq_no_seq;
	}
	public void setFaq_no_seq(int faq_no_seq) {
		this.faq_no_seq = faq_no_seq;
	}
	public String getFaq_title() {
		return faq_title;
	}
	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	public Date getFaq_regdate() {
		return faq_regdate;
	}
	public void setFaq_regdate(Date faq_regdate) {
		this.faq_regdate = faq_regdate;
	}
	public int getR() {
		return r;
	}
	public void setR(int r) {
		this.r = r;
	}
	
	

}
