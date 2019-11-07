package com.opt.dto;

import java.sql.Date;

public class OrderListDto {
	private int r;
	private Date pay_date;
	private String name;
	private String pay_all;
	
	
	public OrderListDto() {
	}
	
	public OrderListDto(int r, Date pay_date, String name, String pay_all) {
		this.r = r;
		this.pay_date = pay_date;
		this.name = name;
		this.pay_all = pay_all;
	}

	public int getR() {
		return r;
	}
	public void setR(int r) {
		this.r = r;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPay_all() {
		return pay_all;
	}
	public void setPay_all(String pay_all) {
		this.pay_all = pay_all;
	}
	
	
	
}
