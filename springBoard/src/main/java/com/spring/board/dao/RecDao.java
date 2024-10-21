package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitVo;

public interface RecDao {

	public RecruitVo selectByNameAndPhone(RecruitVo recruitVo);
	
	public int login(RecruitVo recruitVo);
	
	public RecruitVo selectBySeq(String seq);
	
	public List<EducationVo> selectFromEducationBySeq(String seq);
	
	public List<CareerVo> selectFromCarerrBySeq(String seq);
	
	public List<CertificateVo> selectFromCertificateBySeq(String seq);
}
