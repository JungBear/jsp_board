package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.MbtiDao;
import com.spring.board.vo.QuestionVo;

@Repository
public class MbtiDaoImpl implements MbtiDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<QuestionVo> questionList(int page) {
		return sqlSession.selectList("mbti.questionList", page);
	}
	@Override
	public List<QuestionVo> questionList() {
		return sqlSession.selectList("mbti.allQuestionList");
	}
}
