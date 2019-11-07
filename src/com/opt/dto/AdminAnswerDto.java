package com.opt.dto;

import java.util.Date;

public class AdminAnswerDto {
	private int customer_no_seq;
	private int opt_no_seq;
	private int admin_answer_no_seq;
	private String admin_answer_content;
	private Date admin_answer_regdate;
	
	public int getCustomer_no_seq() {
		return customer_no_seq;
	}
	public void setCustomer_no_seq(int customer_no_seq) {
		this.customer_no_seq = customer_no_seq;
	}
	public int getOpt_no_seq() {
		return opt_no_seq;
	}
	public void setOpt_no_seq(int opt_no_seq) {
		this.opt_no_seq = opt_no_seq;
	}
	public int getAdmin_answer_no_seq() {
		return admin_answer_no_seq;
	}
	public void setAdmin_answer_no_seq(int admin_answer_no_seq) {
		this.admin_answer_no_seq = admin_answer_no_seq;
	}
	public String getAdmin_answer_content() {
		return admin_answer_content;
	}
	public void setAdmin_answer_content(String admin_answer_content) {
		this.admin_answer_content = admin_answer_content;
	}
	public Date getAdmin_answer_regdate() {
		return admin_answer_regdate;
	}
	public void setAdmin_answer_regdate(Date admin_answer_regdate) {
		this.admin_answer_regdate = admin_answer_regdate;
	}

}
