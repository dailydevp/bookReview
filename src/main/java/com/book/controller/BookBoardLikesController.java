package com.book.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.domain.BookLikesVO;
import com.book.service.BookLikesService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/booklikes")
@Log4j
@AllArgsConstructor
public class BookBoardLikesController {
	
	public BookLikesService service;
	
	@PostMapping("/update")
	@ResponseBody
	public Map<String, String> update(@RequestBody BookLikesVO vo){
		log.info("좋아요 업데이트");
		log.info(vo);
		log.info(vo.getLno());
		
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			service.update(vo);
			map.put("result", "success !!!!!!!");
			log.info(vo.getLno());
		}catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail 실패ㅠㅠ");
		}
		return map;
	}

}
