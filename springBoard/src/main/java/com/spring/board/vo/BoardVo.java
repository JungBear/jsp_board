package com.spring.board.vo;

public class BoardVo {
	
	private String 	boardType;
	private String 	boardTypeName;
	private int 	boardNum;
	private String 	boardTitle;
	private String 	boardComment;
	private String 	creator;
	private String 	createTime;
	private String 	creatorName;
	private String	modifier;
	private int totalCnt;
	private int numRow;
	
	
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardComment() {
		return boardComment;
	}
	public void setBoardComment(String boardComment) {
		this.boardComment = boardComment;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	
	
	public int getNumRow() {
		return numRow;
	}
	public void setNumRow(int numRow) {
		this.numRow = numRow;
	}
	public String getBoardTypeName() {
		return boardTypeName;
	}
	public void setBoardTypeName(String boardTypeName) {
		this.boardTypeName = boardTypeName;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	
	
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	@Override
	public String toString() {
		return "BoardVo [boardType=" + boardType + ", boardTypeName=" + boardTypeName + ", boardNum=" + boardNum
				+ ", boardTitle=" + boardTitle + ", boardComment=" + boardComment + ", creator=" + creator
				+ ", creatorName=" + creatorName + ", modifier=" + modifier + ", totalCnt=" + totalCnt + ", numRow="
				+ numRow + "]";
	}

	


	
	
	
	
}
