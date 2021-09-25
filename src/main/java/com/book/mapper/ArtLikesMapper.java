package com.book.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.book.domain.ArtLikesVO;

public interface ArtLikesMapper {
	
	public int count(ArtLikesVO vo);
	
	public int getInfo(ArtLikesVO vo);
	
	public void insert(ArtLikesVO vo);
	
	public int update(ArtLikesVO vo);
	
	public List<Long> list(String usermail);
	
	public Long clickAdd(@Param("usermail")String usermail, @Param("bno") Long bno);

}
