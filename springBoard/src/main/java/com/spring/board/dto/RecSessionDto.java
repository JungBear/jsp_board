package com.spring.board.dto;

public class RecSessionDto {
	private String seq;
	private String name;
	private String phone;
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public RecSessionDto(String seq, String name, String phone) {
		this.seq = seq;
		this.name = name;
		this.phone = phone;
	}
	
	@Override
	public String toString() {
		return "RecSessionDto [seq=" + seq + ", name=" + name + ", phone=" + phone + "]";
	}
}
