package com.book.service;

import java.util.List;

import com.book.domain.ArtReplyVO;

public interface ArtReplyService {
	
	public int write(ArtReplyVO vo);

	public ArtReplyVO read(Long rno);
	
	public int modify(ArtReplyVO vo);

	public int delete(Long rno);

	public List<ArtReplyVO> getList(Long bno);	

	
}
