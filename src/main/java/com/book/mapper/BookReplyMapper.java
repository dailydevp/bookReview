package com.book.mapper;

import java.util.List;


import com.book.domain.BookReplyVO;
import com.book.domain.UserVO;

public interface BookReplyMapper {
	
	public List<BookReplyVO> getList(Long bno);

	public int insert(BookReplyVO vo);
	
	public int insertSelectKey(BookReplyVO vo);
	
	public BookReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(BookReplyVO vo);
	
	public int getCountByBno(Long bno);
	
	public int deleteByBno(Long bno);
	
	public void deleteByUsermail(UserVO vo);
	
	public void deleteByBnoUsermail(UserVO vo);
	
	
}
