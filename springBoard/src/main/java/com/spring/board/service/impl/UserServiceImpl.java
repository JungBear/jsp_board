package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.impl.UserDaoImpl;
import com.spring.board.dto.LoginDto;
import com.spring.board.dto.SessionUserDto;
import com.spring.board.service.UserService;
import com.spring.board.vo.OptionVo;
import com.spring.board.vo.UserVo;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDaoImpl userDao;
	
	@Override
	public int isDuplication(String userId) throws Exception {
		return userDao.isDuplication(userId);
	}
	
	@Override
	public int join(UserVo userVo) throws Exception {
		return userDao.join(userVo);
	}
	
	@Override
	public LoginDto login(LoginDto dto) throws Exception {
		return userDao.login(dto);
	}
	


}
