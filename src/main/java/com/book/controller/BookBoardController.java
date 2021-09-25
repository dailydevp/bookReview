package com.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@RequestMapping("/list")
	public void list() {
		
	}
	
	@RequestMapping("/write")
	public void write() {
		
	}
	
	@RequestMapping("/read")
	public void read() {
		
	}

}
