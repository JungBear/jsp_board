package com.spring.board.service;

import com.spring.board.dto.LoginDto;
import com.spring.board.dto.SessionUserDto;
import com.spring.board.vo.UserVo;

public interface UserService {
	
	public int isDuplication(String userId) throws Exception;
	
	public int join(UserVo userVo) throws Exception;
	
	public LoginDto login(LoginDto dto) throws Exception;
	

}
