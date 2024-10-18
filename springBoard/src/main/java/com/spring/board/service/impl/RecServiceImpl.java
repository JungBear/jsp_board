package com.spring.board.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.impl.RecDaoImpl;
import com.spring.board.service.RecService;
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
}
