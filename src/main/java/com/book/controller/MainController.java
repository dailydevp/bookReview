package com.book.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.book.domain.BookBoardVO;
import com.book.domain.Criteria;
import com.book.domain.PageDTO;
import com.book.service.BookBoardSerive;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/main")
@Log4j
public class MainController {
	
	@Setter(onMethod_=@Autowired)
	private BookBoardSerive service;
	

	@GetMapping("/homePage")
	public void homePage() {
		log.info("mainaPages");
	}
	
	@GetMapping("/homep")
	public void homep() {
		
	}
	
	@GetMapping("/home")
	public void home(@ModelAttribute("cri")Criteria cri, Model model, Principal principal) {
		int total = service.getTotal(cri);
		
		List<BookBoardVO> list = service.getList(cri);
		
		model.addAttribute("list" , list);
		model.addAttribute("pageMaker" , new PageDTO(cri, total));
	}
}
