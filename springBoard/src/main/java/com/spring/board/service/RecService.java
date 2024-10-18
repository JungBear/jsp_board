package com.spring.board.service;

import com.spring.board.vo.RecruitVo;

public interface RecService {
	
	public RecruitVo selectByNameAndPhone(RecruitVo recruitVo);
	
	public int login(RecruitVo recruitVo);

}
