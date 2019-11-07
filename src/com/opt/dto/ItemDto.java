package com.opt.dto;

public class ItemDto {
	private int item_num_seq;
	private String item_name;
	private String item_price;
	private int item_views_no;
	private String item_content;
	private String item_url;
	private int item_count;
	private String item_enabled;
	
	public String getItem_enabled() {
		return item_enabled;
	}
	public void setItem_enabled(String item_enabled) {
		this.item_enabled = item_enabled;
	}
	public int getItem_count() {
		return item_count;
	}
	public void setItem_count(int item_count) {
		this.item_count = item_count;
	}
	public int getItem_num_seq() {
		return item_num_seq;
	}
	public void setItem_num_seq(int item_num_seq) {
		this.item_num_seq = item_num_seq;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_price() {
		return item_price;
	}
	public void setItem_price(String item_price) {
		this.item_price = item_price;
	}
	public int getItem_views_no() {
		return item_views_no;
	}
	public void setItem_views_no(int item_views_no) {
		this.item_views_no = item_views_no;
	}
	public String getItem_content() {
		return item_content;
	}
	public void setItem_content(String item_content) {
		this.item_content = item_content;
	}
	public String getItem_url() {
		return item_url;
	}
	public void setItem_url(String item_url) {
		this.item_url = item_url;
	}
	
}
