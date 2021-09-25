package com.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/secure")
@Log4j
public class SecureController {
	
	@GetMapping(value = "/all", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String all() {
		log.info("everyone");
		return "모두 접근 ok";
	}
	
	@GetMapping(value="/member",produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String member() {
		log.info("member only");
		return "멤버온리";
	}
	
	@GetMapping(value="/admin" , produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String admin() {
		log.info("admin only");
		return "관리자전용";
	}

}
