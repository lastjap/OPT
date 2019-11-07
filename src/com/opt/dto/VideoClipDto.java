package com.opt.dto;

import java.util.Date;

public class VideoClipDto {
	private int r;
	private int video_no_seq;
	private int opt_no_seq;
	private String opt_id;
	private String video_url;
	private String video_title;
	private String video_content;
	private Date video_regdate;
	private int video_views_no;
	public int getR() {
		return r;
	}
	public void setR(int r) {
		this.r = r;
	}
	public int getVideo_no_seq() {
		return video_no_seq;
	}
	public void setVideo_no_seq(int video_no_seq) {
		this.video_no_seq = video_no_seq;
	}
	public int getOpt_no_seq() {
		return opt_no_seq;
	}
	public void setOpt_no_seq(int opt_no_seq) {
		this.opt_no_seq = opt_no_seq;
	}
	public String getOpt_id() {
		return opt_id;
	}
	public void setOpt_id(String opt_id) {
		this.opt_id = opt_id;
	}
	public String getVideo_url() {
		return video_url;
	}
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}
	public String getVideo_title() {
		return video_title;
	}
	public void setVideo_title(String video_title) {
		this.video_title = video_title;
	}
	public String getVideo_content() {
		return video_content;
	}
	public void setVideo_content(String video_content) {
		this.video_content = video_content;
	}
	public Date getVideo_regdate() {
		return video_regdate;
	}
	public void setVideo_regdate(Date video_regdate) {
		this.video_regdate = video_regdate;
	}
	public int getVideo_views_no() {
		return video_views_no;
	}
	public void setVideo_views_no(int video_views_no) {
		this.video_views_no = video_views_no;
	}
	
}
