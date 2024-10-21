package com.spring.board.dto;

import java.util.List;

import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitVo;

public class RecDto {
	private RecruitVo recruit;
	private List<EducationVo> educations;
	private List<CareerVo> careers;
	private List<CertificateVo> certificates;
	public RecruitVo getRecruit() {
		return recruit;
	}
	public void setRecruit(RecruitVo recruit) {
		this.recruit = recruit;
	}
	public List<EducationVo> getEducations() {
		return educations;
	}
	public void setEducations(List<EducationVo> educations) {
		this.educations = educations;
	}
	public List<CareerVo> getCareers() {
		return careers;
	}
	public void setCareers(List<CareerVo> careers) {
		this.careers = careers;
	}
	public List<CertificateVo> getCertificates() {
		return certificates;
	}
	public void setCertificates(List<CertificateVo> certificates) {
		this.certificates = certificates;
	}

	
	
}
