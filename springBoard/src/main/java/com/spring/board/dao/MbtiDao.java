package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.QuestionVo;

public interface MbtiDao {
	
	public List<QuestionVo> questionList(int page);
	
	public List<QuestionVo> questionList();

}
