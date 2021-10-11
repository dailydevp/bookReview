package com.book.mapper;

import java.util.List;

import com.book.domain.BookBoardVO;
import com.book.domain.Criteria;
import com.book.domain.UserVO;

public interface BookBoardMapper {
	
	public List<BookBoardVO> getList();
	
	public List<BookBoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BookBoardVO board);
	
	public void insertSelectKey(BookBoardVO board);
	
	public BookBoardVO read(long bno);
	
	public int delete(long bno);
	
	public int update(BookBoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void deleteByUsermail(UserVO vo);

	public int views(Long bno);
	
	public int likes(Long bno);
}
