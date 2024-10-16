package com.spring.board.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.impl.MbtiDaoImpl;
import com.spring.board.service.MbtiService;
import com.spring.board.vo.QuestionVo;
import com.spring.board.vo.ResultVo;

@Service
public class MbtiServiceImpl implements MbtiService{
	
	@Autowired
	MbtiDaoImpl mbtiDao;	

	@Override
	public List<QuestionVo> questionList(int page) {
		return mbtiDao.questionList(page);
	}
	
	private static final String[] MBTI_TYPE = {"E", "I", "N", "S", "F", "T", "J", "P"};

	@Override
	public ResultVo calculateMbtiResult(List<Integer> allAnswers) {
		// TODO Auto-generated method stub
		List<QuestionVo> questions = mbtiDao.questionList();
	
		Map<String, Integer> scores = new HashMap<>();
		for (String type : MBTI_TYPE) {
			scores.put(type, 0);
		}
		
		for(int z = 0; z < allAnswers.size(); z++) {
			
			QuestionVo question = questions.get(z);
			
			// 1 ~ 7
			int answer = allAnswers.get(z);
			
			// 가져온 질문의 타입 쌍 분리
			String[] type = question.getBoardType().split("");

			 switch(answer) {
             case 1: scores.put(type[0], scores.get(type[0]) + 3); break;
             case 2: scores.put(type[0], scores.get(type[0]) + 2); break;
             case 3: scores.put(type[0], scores.get(type[0]) + 1); break;
             case 4: break; 
             case 5: scores.put(type[1], scores.get(type[1]) + 1); break;
             case 6: scores.put(type[1], scores.get(type[1]) + 2); break;
             case 7: scores.put(type[1], scores.get(type[1]) + 3); break;
			 }
		}	
			
		StringBuilder result = new StringBuilder();
		for(int z = 0; z < MBTI_TYPE.length; z += 2) {
			result.append(scores.get(MBTI_TYPE[z]) >= scores.get(MBTI_TYPE[z + 1]) ? MBTI_TYPE[z] : MBTI_TYPE[z + 1]);
		}
		
		ResultVo resultVo = new ResultVo(result.toString());
		
		return resultVo;
	}
	

	

}
