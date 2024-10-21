package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.RecDao;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
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
	
	@Override
	public RecruitVo selectBySeq(String seq) {
		return sqlSession.selectOne("rec.selectBySeq", seq);
	}
	
	@Override
	public List<EducationVo> selectFromEducationBySeq(String seq) {
		return sqlSession.selectList("rec.selectFromEducationBySeq", seq);
	}
	
	@Override
	public List<CareerVo> selectFromCarerrBySeq(String seq) {
		return sqlSession.selectList("rec.selectFromCarerrBySeq", seq);
	}
	
	@Override
	public List<CertificateVo> selectFromCertificateBySeq(String seq) {
		return sqlSession.selectList("rec.selectFromCertificateBySeq", seq);
	}
}
