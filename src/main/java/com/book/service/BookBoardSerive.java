package com.book.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.book.domain.BookBoardVO;
import com.book.domain.Criteria;

public interface BookBoardSerive {
	
	public BookBoardVO read(Long bno);
	
	public List<BookBoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public void write(BookBoardVO board);
	
	public void write(BookBoardVO board, MultipartFile[] files);
	
	public boolean modify(BookBoardVO board);
	
	public boolean modify(BookBoardVO board, MultipartFile[] files);
	
	public boolean delete(Long bno);
	
	public int views(Long bno);
	
	public int likes(Long bno);

}
