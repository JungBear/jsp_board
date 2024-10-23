package com.spring.board.service;

import java.util.List;

import com.spring.board.dto.RecDto;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitVo;

public interface RecService {
	
	public RecruitVo selectByNameAndPhone(RecruitVo recruitVo);
	
	public int login(RecruitVo recruitVo);
	
	public RecruitVo getRecruit(String seq);
	
	public List<EducationVo> getEducation(String seq);

	public List<CareerVo> getCarrer(String seq);
	
	public List<CertificateVo> getCertificate(String seq);
	
	public boolean save(RecDto recDto, String action);	
}
