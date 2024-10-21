package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.impl.RecDaoImpl;
import com.spring.board.service.RecService;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitVo;

@Service
public class RecServiceImpl implements RecService{
	@Autowired
	RecDaoImpl recDao;
	
	@Override
	public RecruitVo selectByNameAndPhone(RecruitVo recruitVo) {
		return recDao.selectByNameAndPhone(recruitVo);
	}
	
	@Override
	public int login(RecruitVo recruitVo) {
		return recDao.login(recruitVo);
	}
	
	@Override
	public RecruitVo getRecruit(String seq) {
		return recDao.selectBySeq(seq);
	}
	
	@Override
	public List<EducationVo> getEducation(String seq) {
		return recDao.selectFromEducationBySeq(seq);
	}
	 
	@Override
	public List<CareerVo> getCarrer(String seq) {
		return recDao.selectFromCarerrBySeq(seq);
	}
	
	@Override
	public List<CertificateVo> getCertificate(String seq) {
		return recDao.selectFromCertificateBySeq(seq);
	}
}
