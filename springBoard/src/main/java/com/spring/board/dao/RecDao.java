package com.spring.board.dao;

import com.spring.board.vo.RecruitVo;

public interface RecDao {

	public RecruitVo selectByNameAndPhone(RecruitVo recruitVo);
	
	public int login(RecruitVo recruitVo);
}
