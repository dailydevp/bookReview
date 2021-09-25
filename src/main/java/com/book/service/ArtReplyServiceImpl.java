package com.book.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.domain.ArtReplyVO;
import com.book.mapper.ArtReplyMapper;

import lombok.Setter;

@Service
public class ArtReplyServiceImpl implements ArtReplyService{
	
	@Setter(onMethod_=@Autowired)
	private ArtReplyMapper mapper;

	@Override
	public int write(ArtReplyVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public ArtReplyVO read(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(ArtReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(Long rno) {
		return mapper.delete(rno);
	}

	@Override
	public List<ArtReplyVO> getList(Long bno) {
		return mapper.getList(bno);
	}

}
