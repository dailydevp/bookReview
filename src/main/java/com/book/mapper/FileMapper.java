package com.book.mapper;

import com.book.domain.FileVO;
import com.book.domain.UserVO;

public interface FileMapper {

	public int insert(FileVO vo);
	
	public void deleteByBno(Long bno);
	
	public void deleteByUsermail(UserVO user);


}
