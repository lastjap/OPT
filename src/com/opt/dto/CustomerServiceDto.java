package com.opt.dto;

import java.util.Date;

public class CustomerServiceDto {
	private int customer_no_seq;
	private int opt_no_seq;
	private String customer_title;
	private String customer_content;
	private Date customer_regdate;
	private String customer_category;
	private int r;
	private String opt_id;
	private String admin_answer_content;
	
	public String getAdmin_answer_content() {
		return admin_answer_content;
	}
	public void setAdmin_answer_content(String admin_answer_content) {
		this.admin_answer_content = admin_answer_content;
	}
	public String getOpt_id() {
		return opt_id;
	}
	public void setOpt_id(String opt_id) {
		this.opt_id = opt_id;
	}
	public String getCustomer_category() {
		return customer_category;
	}
	public void setCustomer_category(String customer_category) {
		this.customer_category = customer_category;
	}
	public int getR() {
		return r;
	}
	public void setR(int r) {
		this.r = r;
	}
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
	public String getCustomer_title() {
		return customer_title;
	}
	public void setCustomer_title(String customer_title) {
		this.customer_title = customer_title;
	}
	public String getCustomer_content() {
		return customer_content;
	}
	public void setCustomer_content(String customer_content) {
		this.customer_content = customer_content;
	}
	public Date getCustomer_regdate() {
		return customer_regdate;
	}
	public void setCustomer_regdate(Date customer_regdate) {
		this.customer_regdate = customer_regdate;
	}

}
