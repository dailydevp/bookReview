package com.book.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.domain.BookReplyVO;
import com.book.mapper.BookReplyMapper;

import lombok.Setter;

@Service
public class BookReplyServiceImpl implements BookReplyService{
	
	@Setter(onMethod_=@Autowired)
	private BookReplyMapper mapper;

	@Override
	public int write(BookReplyVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public BookReplyVO read(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(BookReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(Long rno) {
		return mapper.delete(rno);
	}

	@Override
	public List<BookReplyVO> getList(Long bno) {
		return mapper.getList(bno);
	}

}
