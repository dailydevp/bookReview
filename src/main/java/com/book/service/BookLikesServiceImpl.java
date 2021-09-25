package com.book.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.domain.BookLikesVO;
import com.book.mapper.BookLikesMapper;

import lombok.Setter;

@Service
public class BookLikesServiceImpl implements BookLikesService{
	
	@Setter(onMethod_=@Autowired)
	public BookLikesMapper mapper;

	@Override
	public int likescount(BookLikesVO vo) {
		return mapper.likescount(vo);
	}

	@Override
	public int getInfo(BookLikesVO vo) {
		return mapper.getInfo(vo);
	}

	@Override
	public void insert(BookLikesVO vo) {
		mapper.insert(vo);
		
	}

	@Override
	public void update(BookLikesVO vo) {
		if(mapper.update(vo)==0) {
			mapper.insert(vo);
		}
		
	}

	@Override
	public List<Long> getList(String usermail) {
		return mapper.getList(usermail);
	}

	@Override
	public Long getLikeClick(String usermail, Long bno) {
		return mapper.getLikeClick(usermail, bno);
	}

}
