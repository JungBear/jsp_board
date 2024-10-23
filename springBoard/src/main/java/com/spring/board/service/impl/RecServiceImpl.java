package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.board.dao.impl.RecDaoImpl;
import com.spring.board.dto.RecDto;
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
	@Transactional
	public int login(RecruitVo recruitVo) {
		return recDao.login(recruitVo);
	}
	
	@Override
	@Transactional(readOnly = true)
	public RecruitVo getRecruit(String seq) {
		return recDao.selectBySeq(seq);
	}
	
	@Override
	@Transactional(readOnly = true)
	public List<EducationVo> getEducation(String seq) {
		return recDao.selectFromEducationBySeq(seq);
	}
	 
	@Override
	@Transactional(readOnly = true)
	public List<CareerVo> getCarrer(String seq) {
		return recDao.selectFromCarerrBySeq(seq);
	}
	
	@Override
	@Transactional(readOnly = true)
	public List<CertificateVo> getCertificate(String seq) {
		return recDao.selectFromCertificateBySeq(seq);
	}
	
	@Override
	@Transactional
	public boolean save(RecDto recDto, String action) {
	    if (recDto == null) {
	        throw new IllegalArgumentException("������ �����Ͱ� �����ϴ�.");
	    }
	    
	    RecruitVo recruitVo = recDto.getRecruit();
	    List<EducationVo> educationVos = recDto.getEducations();
	    
	    if (recruitVo == null) {
	        throw new IllegalArgumentException("Rec Empty");
	    }
	    if (educationVos == null || educationVos.isEmpty()) {
	        throw new IllegalArgumentException("Edu Empty");
	    }

	    RecruitVo existingRecruit = recDao.selectBySeq(recruitVo.getSeq());
	    
	    try {
	        if (existingRecruit != null) {
	            if (recDao.updateRecruit(recruitVo) != 1) {
	                throw new RuntimeException("������ ���� ���� ����. ����� �ٽ� �õ����ּ���.");
	            }
	        } else {
	            if (recDao.insertRecruits(recruitVo) != 1) {
	                throw new RuntimeException("������ ���� ���� ����. ����� �ٽ� �õ����ּ���.");
	            }
	        }

	        recDao.deleteEducationsBySeq(recruitVo.getSeq());
	        for(EducationVo educationVo : educationVos) {
	            if(recDao.insertEducations(educationVo) != 1) {
	                throw new RuntimeException("�з� ���� ���� ����. ����� �ٽ� �õ����ּ���.");
	            }
	        }
	        
	        List<CareerVo> careerVos = recDto.getCareers();
	        recDao.deleteCareersBySeq(recruitVo.getSeq());
	        if (careerVos != null && !careerVos.isEmpty()) {
	            for(CareerVo careerVo : careerVos) {
	                if(recDao.insertCareers(careerVo) != 1) {
	                    throw new RuntimeException("��� ���� ���� ����. ����� �ٽ� �õ����ּ���.");
	                }
	            }	
	        }

	        List<CertificateVo> certificateVos = recDto.getCertificates();
	        recDao.deleteCertificatesBySeq(recruitVo.getSeq());
	        if (certificateVos != null && !certificateVos.isEmpty()) {
	            for(CertificateVo certificateVo : certificateVos) {
	                if(recDao.insertCertificates(certificateVo) != 1) {
	                    throw new RuntimeException("�ڰ��� ���� ���� ����. ����� �ٽ� �õ����ּ���.");
	                }
	            }
	        }
	        
	        if(action.equals("submit")) {
	        	if(recDao.updateSubmit(recruitVo.getSeq()) != 1) {
	        		throw new RuntimeException("���� ����.");
	        	}
	        }
	        
	        return true;
	    } catch (Exception e) {
	        throw new RuntimeException("���� �� ������ �߻��߽��ϴ�: " + e.getMessage());
	    }
	}
}
