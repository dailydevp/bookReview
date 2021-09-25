package com.book.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.book.domain.BookLikesVO;

public interface BookLikesMapper {
	
	public int likescount(BookLikesVO vo);
	
	public int getInfo(BookLikesVO vo);
	
	public void insert(BookLikesVO vo);
	
	public int update(BookLikesVO vo);
	
	public List<Long> getList(String usermail);
	
	public Long getLikeClick(@Param("usermail") String usermail, @Param("bno") Long bno);

}
