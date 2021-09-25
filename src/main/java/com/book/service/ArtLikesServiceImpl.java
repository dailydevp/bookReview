package com.book.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.domain.ArtLikesVO;
import com.book.mapper.ArtLikesMapper;

import lombok.Setter;

@Service
public class ArtLikesServiceImpl implements ArtLikesService {
	
	@Setter(onMethod_=@Autowired)
	public ArtLikesMapper mapper;

	@Override
	public int count(ArtLikesVO vo) {
		return mapper.count(vo);
	}

	@Override
	public int getInfo(ArtLikesVO vo) {
		return mapper.getInfo(vo);
	}

	@Override
	public void insert(ArtLikesVO vo) {
		mapper.insert(vo);
	}

	@Override
	public void update(ArtLikesVO vo) {
		if(mapper.update(vo) == 0) {
			mapper.insert(vo);
		}
	}

	@Override
	public List<Long> getList(String usermail) {
		return mapper.list(usermail);
	}

	@Override
	public Long ClickAdd(String usermail, Long bno) {
		return mapper.clickAdd(usermail, bno);
	}

}
