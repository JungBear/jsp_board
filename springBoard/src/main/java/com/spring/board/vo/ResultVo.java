package com.spring.board.vo;

public class ResultVo {
	private String mbti;
	private String decription;
	
	
	public String getMbti() {
		return mbti;
	}
	public void setMbti(String mbti) {
		this.mbti = mbti;
	}
	public String getDecription() {
		return decription;
	}
	public void setDecription(String decription) {
		this.decription = decription;
	}
	
	public ResultVo(String mbti) {
		super();
		this.mbti = mbti;
	}
	
	
}
