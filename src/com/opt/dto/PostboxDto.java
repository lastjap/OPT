package com.opt.dto;

public class PostboxDto {
	private int r;
	private String opt_id;
	private int opt_no_seq;
	private int post_no_seq;
	private String post_recive_id;
	private String post_title;
	private String post_content;
	private String post_send_date;
	private String post_recive_read;
	private String post_read_date;
	private String post_send_del;
	private String post_read_del;
	
	
	public PostboxDto() {
		super();
	}


	public PostboxDto(int r, String opt_id, int opt_no_seq, int post_no_seq, String post_recive_id, String post_title,
			String post_content, String post_send_date, String post_recive_read, String post_read_date,
			String post_send_del, String post_read_del) {
		super();
		this.r = r;
		this.opt_id = opt_id;
		this.opt_no_seq = opt_no_seq;
		this.post_no_seq = post_no_seq;
		this.post_recive_id = post_recive_id;
		this.post_title = post_title;
		this.post_content = post_content;
		this.post_send_date = post_send_date;
		this.post_recive_read = post_recive_read;
		this.post_read_date = post_read_date;
		this.post_send_del = post_send_del;
		this.post_read_del = post_read_del;
	}


	public int getR() {
		return r;
	}


	public void setR(int r) {
		this.r = r;
	}


	public String getOpt_id() {
		return opt_id;
	}


	public void setOpt_id(String opt_id) {
		this.opt_id = opt_id;
	}


	public int getOpt_no_seq() {
		return opt_no_seq;
	}


	public void setOpt_no_seq(int opt_no_seq) {
		this.opt_no_seq = opt_no_seq;
	}


	public int getPost_no_seq() {
		return post_no_seq;
	}


	public void setPost_no_seq(int post_no_seq) {
		this.post_no_seq = post_no_seq;
	}


	public String getPost_recive_id() {
		return post_recive_id;
	}


	public void setPost_recive_id(String post_recive_id) {
		this.post_recive_id = post_recive_id;
	}


	public String getPost_title() {
		return post_title;
	}


	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}


	public String getPost_content() {
		return post_content;
	}


	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}


	public String getPost_send_date() {
		return post_send_date;
	}


	public void setPost_send_date(String post_send_date) {
		this.post_send_date = post_send_date;
	}


	public String getPost_recive_read() {
		return post_recive_read;
	}


	public void setPost_recive_read(String post_recive_read) {
		this.post_recive_read = post_recive_read;
	}


	public String getPost_read_date() {
		return post_read_date;
	}


	public void setPost_read_date(String post_read_date) {
		this.post_read_date = post_read_date;
	}


	public String getPost_send_del() {
		return post_send_del;
	}


	public void setPost_send_del(String post_send_del) {
		this.post_send_del = post_send_del;
	}


	public String getPost_read_del() {
		return post_read_del;
	}


	public void setPost_read_del(String post_read_del) {
		this.post_read_del = post_read_del;
	}
	
	
	
	
}
