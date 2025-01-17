package com.spring.board.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.OptionVo;
import com.spring.board.vo.PageVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo, List<String> boardTypes) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("pageNo", pageVo.getPageNo());
		map.put("boardTypes", boardTypes);
		
		return sqlSession.selectList("board.boardList",map);
	}
	
	@Override
	public int selectBoardCnt(List<String> boardTypes) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardTypes", boardTypes);
		
		return sqlSession.selectOne("board.boardTotal",map);
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	
	@Override
	public List<OptionVo> optionList(String type) throws Exception {
		return sqlSession.selectList("board.optionList", type);
	}
}
