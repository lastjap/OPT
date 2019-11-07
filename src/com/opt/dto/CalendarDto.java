package com.opt.dto;

import java.util.Date;

public class CalendarDto {
	private int calendar_no_seq;
	private int opt_no_seq;
	private String calendar_title;
	private String calendar_startday;
	private String calendar_enddate;
	private String calendar_url;
	private Date calendar_regdate;
	private int count;
	private String nextDate;
	
	
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getNextDate() {
		return nextDate;
	}
	public void setNextDate(String nextDate) {
		this.nextDate = nextDate;
	}
	public int getCalendar_no_seq() {
		return calendar_no_seq;
	}
	public void setCalendar_no_seq(int calendar_no_seq) {
		this.calendar_no_seq = calendar_no_seq;
	}
	public int getOpt_no_seq() {
		return opt_no_seq;
	}
	public void setOpt_no_seq(int opt_no_seq) {
		this.opt_no_seq = opt_no_seq;
	}
	public String getCalendar_title() {
		return calendar_title;
	}
	public void setCalendar_title(String calendar_title) {
		this.calendar_title = calendar_title;
	}
	public String getCalendar_startday() {
		return calendar_startday;
	}
	public void setCalendar_startday(String calendar_startday) {
		this.calendar_startday = calendar_startday;
	}
	public String getCalendar_enddate() {
		return calendar_enddate;
	}
	public void setCalendar_enddate(String calendar_enddate) {
		this.calendar_enddate = calendar_enddate;
	}
	public String getCalendar_url() {
		return calendar_url;
	}
	public void setCalendar_url(String calendar_url) {
		this.calendar_url = calendar_url;
	}
	public Date getCalendar_regdate() {
		return calendar_regdate;
	}
	public void setCalendar_regdate(Date calendar_regdate) {
		this.calendar_regdate = calendar_regdate;
	}
	
}
