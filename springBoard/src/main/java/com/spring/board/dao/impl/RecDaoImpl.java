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
	
	@Override
	public int insertRecruits(RecruitVo recruitVo) {
		return sqlSession.insert("rec.insertRecruits", recruitVo);
	}
	
	@Override
	public int insertEducations(EducationVo educationVos) {
		return sqlSession.insert("rec.insertEducations", educationVos);
	}
	
	@Override
	public int insertCareers(CareerVo careerVos) {
		return sqlSession.insert("rec.insertCareers", careerVos);
	}
	
	@Override
	public int insertCertificates(CertificateVo certificateVos) {
		return sqlSession.insert("rec.insertCertificates", certificateVos);
	}
	
	@Override
	public int updateRecruit(RecruitVo recruitVo) {
		return sqlSession.update("rec.updateRecruit", recruitVo);
	}
	
	@Override
	public int deleteEducationsBySeq(String seq) {
		return sqlSession.delete("rec.deleteEducationsBySeq", seq);
	}
	
	@Override
	public int deleteCareersBySeq(String seq) {
		return sqlSession.delete("rec.deleteCareersBySeq", seq);
	}
	
	@Override
	public int deleteCertificatesBySeq(String seq) {
		return sqlSession.delete("rec.deleteCertificatesBySeq", seq);
	}
	
	@Override
	public int updateSubmit(String seq) {
		return sqlSession.update("rec.updateSubmit", seq);
	}
}
