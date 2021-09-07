package com.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Getter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
public class MemberController {

	
	@GetMapping("/signup")
	public void signupForm() {
		
	}
	
	@PostMapping("/signup")
	public void signup() {
		
	}
	
	@GetMapping("/signin")
	public void signinForm() {
		
	}
	
	@PostMapping("/signin")
	public void signin() {
		
	}
	
	@RequestMapping("/myinfo")
	public void myinfo() {
		
	}
}
