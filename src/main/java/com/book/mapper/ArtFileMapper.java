package com.book.mapper;

import com.book.domain.ArtFileVO;
import com.book.domain.UserVO;

public interface ArtFileMapper {
	
	public int insert(ArtFileVO vo);
	
	public void deleteByBno(Long bno);
	
	public void deleteByUsermal(UserVO user);

}
