package com.book.mapper;

import java.util.List;

import com.book.domain.ArtBoardVO;
import com.book.domain.Criteria;
import com.book.domain.UserVO;

public interface ArtBoardMapper {

	public List<ArtBoardVO> getList();
	
	public List<ArtBoardVO> getListWithPaging(Criteria cri);
	
	public void insert(ArtBoardVO board);
	
	public void insertSelectKey(ArtBoardVO board);
	
	public ArtBoardVO read(long bno);
	
	public int delete(long bno);
	
	public int update(ArtBoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void deleteByUsermail(UserVO vo);
}
