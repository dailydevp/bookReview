package com.book.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.domain.ArtLikesVO;
import com.book.service.ArtLikesService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/artlikes")
@Log4j
@AllArgsConstructor
public class ArtLikesController {
	
	public ArtLikesService service;
	
	@PostMapping("/update")
	@ResponseBody
	public Map<String, String> update(@RequestBody ArtLikesVO vo){
		log.info("좋아요 업데이트");
		log.info(vo);
		log.info(vo.getLno());
		
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			service.update(vo);
			map.put("result", "좋아요 성공!!!!!!");
			log.info(vo.getLno());
		}catch (Exception e) {
			e.printStackTrace();
			map.put("result", "좋아요 실패ㅠㅠ");
		}
		return map;
	}

}
