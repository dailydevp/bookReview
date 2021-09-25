package com.book.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.book.domain.ArtBoardVO;
import com.book.domain.Criteria;

public interface ArtBoardService {

	public List<ArtBoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public ArtBoardVO read(Long bno);
	
	public void write(ArtBoardVO board);
	
	public void write(ArtBoardVO board, MultipartFile file);
	
	public boolean modify(ArtBoardVO board);
	
	public boolean modify(ArtBoardVO board, MultipartFile file);
	
	public boolean delete(Long bno);
}
