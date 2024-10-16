package com.spring.board.vo;

public class QuestionVo {
	
	private String 	boardType;
	private String 	boardComment;
	
	
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getBoardComment() {
		return boardComment;
	}
	public void setBoardComment(String boardComment) {
		this.boardComment = boardComment;
	}
	@Override
	public String toString() {
		return "QuestionVo [boardType=" + boardType + ", boardComment=" + boardComment + "]";
	}
}
