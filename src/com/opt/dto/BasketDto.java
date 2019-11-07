package com.opt.dto;

public class BasketDto {
	private int opt_no_seq;
	private int basket_no_seq;
	private int basket_item_no;
	private String basket_item_url;
	private String basket_item_name;
	private int basket_item_count;
	private int basket_item_price;
	
	
	public BasketDto(int opt_no_seq, int basket_item_no, String basket_item_url, String basket_item_name,
			int basket_item_count, int basket_item_price) {
		
		this.opt_no_seq = opt_no_seq;
		this.basket_item_no = basket_item_no;
		this.basket_item_url = basket_item_url;
		this.basket_item_name = basket_item_name;
		this.basket_item_count = basket_item_count;
		this.basket_item_price = basket_item_price;
	}


	public BasketDto() {		
	}


	public int getOpt_no_seq() {
		return opt_no_seq;
	}


	public void setOpt_no_seq(int opt_no_seq) {
		this.opt_no_seq = opt_no_seq;
	}


	public int getBasket_no_seq() {
		return basket_no_seq;
	}


	public void setBasket_no_seq(int basket_no_seq) {
		this.basket_no_seq = basket_no_seq;
	}


	public int getBasket_item_no() {
		return basket_item_no;
	}


	public void setBasket_item_no(int basket_item_no) {
		this.basket_item_no = basket_item_no;
	}


	public String getBasket_item_url() {
		return basket_item_url;
	}


	public void setBasket_item_url(String basket_item_url) {
		this.basket_item_url = basket_item_url;
	}


	public String getBasket_item_name() {
		return basket_item_name;
	}


	public void setBasket_item_name(String bakset_item_name) {
		this.basket_item_name = bakset_item_name;
	}


	public int getBasket_item_count() {
		return basket_item_count;
	}


	public void setBasket_item_count(int basket_item_count) {
		this.basket_item_count = basket_item_count;
	}


	public int getBasket_item_price() {
		return basket_item_price;
	}


	public void setBasket_item_price(int basket_item_price) {
		this.basket_item_price = basket_item_price;
	}
	
	
	
	
	
	
}
