package com.book.service;

import java.util.List;

import com.book.domain.ArtLikesVO;

public interface ArtLikesService {
	
	public int count(ArtLikesVO vo);
	
	public int getInfo(ArtLikesVO vo);
	
	public void insert(ArtLikesVO vo);
	
	public void update(ArtLikesVO vo);
	
	public List<Long> getList(String name);
	
	public Long clickAdd(String name, Long bno);


}
