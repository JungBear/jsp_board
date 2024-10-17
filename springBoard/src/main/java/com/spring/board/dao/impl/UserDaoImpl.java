package com.spring.board.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.UserDao;
import com.spring.board.dto.LoginDto;
import com.spring.board.dto.SessionUserDto;
import com.spring.board.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int isDuplication(String userId) throws Exception {
		return sqlSession.selectOne("user.isDuplication", userId);
	}
	
	@Override
	public int join(UserVo userVo) throws Exception {
		return sqlSession.insert("user.join", userVo);
	}
	
	@Override
	public LoginDto login(LoginDto dto) throws Exception {
		return sqlSession.selectOne("user.login", dto);
	}
	
}
