package com.opt.dto;

import java.util.Date;

public class VideoComment {
	private String opt_id; 
	private int opt_no_seq;
	private int video_no_seq;
	private int video_comment_seq;
	private String video_reple;
	private Date video_comment_date;
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
	public int getVideo_no_seq() {
		return video_no_seq;
	}
	public void setVideo_no_seq(int video_no_seq) {
		this.video_no_seq = video_no_seq;
	}
	public int getVideo_comment_seq() {
		return video_comment_seq;
	}
	public void setVideo_comment_seq(int video_comment_seq) {
		this.video_comment_seq = video_comment_seq;
	}
	public String getVideo_reple() {
		return video_reple;
	}
	public void setVideo_reple(String video_reple) {
		this.video_reple = video_reple;
	}
	public Date getVideo_comment_date() {
		return video_comment_date;
	}
	public void setVideo_comment_date(Date video_comment_date) {
		this.video_comment_date = video_comment_date;
	}
	
}
