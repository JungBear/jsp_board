package com.spring.board.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.RecDao;
import com.spring.board.vo.RecruitVo;

@Repository
public class RecDaoImpl implements RecDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public RecruitVo selectByNameAndPhone(RecruitVo recruitVo) {
		return sqlSession.selectOne("rec.selectByNameAndPhone", recruitVo);
	}
	
	@Override
	public int login(RecruitVo recruitVo) {
		return sqlSession.insert("rec.login", recruitVo);
	}
}
