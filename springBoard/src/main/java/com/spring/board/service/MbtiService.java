package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.QuestionVo;
import com.spring.board.vo.ResultVo;

public interface MbtiService {
	public List<QuestionVo> questionList(int page);
	
	public ResultVo calculateMbtiResult(List<Integer> allAnswers);
}
