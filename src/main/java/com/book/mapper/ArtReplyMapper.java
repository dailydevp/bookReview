package com.book.mapper;

import java.util.List;

import com.book.domain.ArtReplyVO;
import com.book.domain.UserVO;

public interface ArtReplyMapper {
	
	public int insert(ArtReplyVO vo);
	
	public int insertSelectKey(ArtReplyVO vo);
	
	public ArtReplyVO read(Long bno);
	
	public int delete(Long rno);
	
	public int update(ArtReplyVO vo);
	
	public List<ArtReplyVO> getList(Long bno); 
	
	public int getCountByBno(Long bno);
	
	public int deleteByBno(Long bno);

	public void removeByUserid(UserVO vo);

	public void removeByBnoByUserid(UserVO vo);
}
