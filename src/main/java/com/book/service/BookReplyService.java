package com.book.service;

import java.util.List;

import com.book.domain.BookReplyVO;

public interface BookReplyService {

	public int write(BookReplyVO vo);
	
	public BookReplyVO read(Long rno);
	
	public int modify(BookReplyVO vo);
	
	public int delete(Long rno);
	
	public List<BookReplyVO> getList(Long bno);
	
}
