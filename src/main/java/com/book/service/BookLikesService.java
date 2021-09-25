package com.book.service;

import java.util.List;

import com.book.domain.BookLikesVO;

public interface BookLikesService {
	
	public int likescount(BookLikesVO vo);
	
	public int getInfo(BookLikesVO vo);
	
	public void insert(BookLikesVO vo);
	
	public void update(BookLikesVO vo);
	
	public List<Long> getList(String name);
	
	public Long getLikeClick(String usermail, Long bno);

}
