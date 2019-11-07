package com.opt.dto;

import java.sql.Date;

public class PaymentDto {
	private int opt_no_seq;
	private int item_num;
	private int pay_seq;
	private String pay_recipient_name;
	private String pay_place;
	private String pay_phone;
	private String pay_memo; 
	private int pay_count;
	private Date pay_date;
	private int pay_total;
	
	public int getOpt_no_seq() {
		return opt_no_seq;
	}
	public void setOpt_no_seq(int opt_no_seq) {
		this.opt_no_seq = opt_no_seq;
	}
	public int getItem_num() {
		return item_num;
	}
	public void setItem_num(int item_num) {
		this.item_num = item_num;
	}
	public int getPay_seq() {
		return pay_seq;
	}
	public void setPay_seq(int pay_seq) {
		this.pay_seq = pay_seq;
	}
	public String getPay_recipient_name() {
		return pay_recipient_name;
	}
	public void setPay_recipient_name(String pay_recipient_name) {
		this.pay_recipient_name = pay_recipient_name;
	}
	public String getPay_place() {
		return pay_place;
	}
	public void setPay_place(String pay_place) {
		this.pay_place = pay_place;
	}
	public String getPay_phone() {
		return pay_phone;
	}
	public void setPay_phone(String pay_phone) {
		this.pay_phone = pay_phone;
	}
	public String getPay_memo() {
		return pay_memo;
	}
	public void setPay_memo(String pay_memo) {
		this.pay_memo = pay_memo;
	}
	public int getPay_count() {
		return pay_count;
	}
	public void setPay_count(int pay_count) {
		this.pay_count = pay_count;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public int getPay_total() {
		return pay_total;
	}
	public void setPay_total(int pay_total) {
		this.pay_total = pay_total;
	}
	
	
	
}
