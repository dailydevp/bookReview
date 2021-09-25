package com.book.controller;

import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book.domain.Criteria;
import com.book.domain.UserVO;
import com.book.security.domain.CustomUser;
import com.book.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	@Setter(onMethod_=@Autowired)
	private UserService service;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder encoder;
	

	@RequestMapping("/fail")
	public void authfail() {
		
	}
	
	@RequestMapping("/signin")
	public void login() {
	
	}

	
	
	@GetMapping("/signup")
	public void signupForm() {
		
	}
	
	@PostMapping("/signup")
	public String signup(UserVO user, RedirectAttributes rttr) {
		log.info(user);
		
		boolean ok = service.insert(user);
		
		if(ok) {
			rttr.addAttribute("status","success");
			return "redirect:/member/signin";
		}else {
			rttr.addAttribute("status", "error");
			return "redirect:/member/signup?error";
		}
	}
	
	@RequestMapping(value="/changePw", method= {RequestMethod.GET,RequestMethod.POST})
	@PreAuthorize("isAuthenticated()")
	public void pwModify(Criteria cri, Principal principal, Model model) {
		log.info(principal.getName());
		UserVO users = service.read(principal.getName());
		
		model.addAttribute("users", users);
		
		
			
	}
	
	@RequestMapping(value={"/myinfo","/profileModify"}, method= {RequestMethod.GET,RequestMethod.POST})
	@PreAuthorize("isAuthenticated()")
	public void myinfo(Criteria cri, Principal principal, Model model) {
		log.info(principal.getName());
		UserVO users = service.read(principal.getName());
		
		model.addAttribute("users", users);
	}
	
	@PostMapping("/modifyInfo")
	@PreAuthorize("principal.username == #user.usermail")
	public String profileModify(UserVO user, RedirectAttributes rttr, Authentication auth) {
		
		log.info("modify page");
		boolean success = service.modifyInfo(user);
		
		if(success) {
			rttr.addAttribute("status","success");
			
			CustomUser mem = (CustomUser) auth.getPrincipal();
			mem.setUser(user);
			log.info("정보수정성공");
		}
		return "redirect:/member/myinfo";		
	}
	
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #user.usermail")
	public String modify(UserVO user, RedirectAttributes rttr, Authentication auth, String oldPassword) {
		boolean success = service.modify(user, oldPassword);
		
		if(success) {
			rttr.addAttribute("status", "success");
			
			CustomUser mem = (CustomUser) auth.getPrincipal();
			mem.setUser(user);
		}else {
			rttr.addAttribute("status","error");
		}
		return "redirect :/member/myinfo";
	}
	
	
	
	
	@RequestMapping(value="/delete" , method= {RequestMethod.GET,RequestMethod.POST})
	@PreAuthorize("principal.username == #user.usermail")
	public String delete(UserVO user, RedirectAttributes rttr, HttpServletRequest req, String oldPassword) throws ServletException{
		log.info(user);
		log.info(user.getUserpw());
		log.info(oldPassword);
		
		boolean success = service.delete(user, oldPassword);
		
		if(success) {
			req.logout();
			return "redirect:/board/list";
		}else {
			rttr.addAttribute("status", "error");
			return "redirect:/member/myinfo";
		}
	}
	
	@GetMapping("/checkMail")
	@ResponseBody
	public ResponseEntity<String[]> checkMail (String usermail) {
		log.info("이메일중복체크");
		
		UserVO user = service.read(usermail);
		
		if(user == null) {
			return new ResponseEntity<> (new String[] {"success", ""}, HttpStatus.OK);
		}else {
			return new ResponseEntity<> (new String[] {"exist", user.getUsermail()}, HttpStatus.OK);
		}
		
	}
	
	@PostMapping("/checkPw")
	public void checkPassword (@ModelAttribute("userpw") String userpw, RedirectAttributes rttr){
		log.info("비밀번호 확인");
		//나중에 다시 생각해보기.
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		UserVO user = service.checkPw(userpw);
		
		if(encoder.matches(userpw, userpw)) {
			rttr.addAttribute("status", "success");
		}else {
			rttr.addAttribute("status","fail");
		}
	}
	
	@GetMapping("/checkNick")
	@ResponseBody
	public ResponseEntity<String> checkNick(String nick){
		log.info("check dup nick");
		
		UserVO user = service.dupNickCheck(nick);
		
		if(user == null) {
			return new ResponseEntity<> ("success" , HttpStatus.OK);
		}else {
			return new ResponseEntity<> ("exist", HttpStatus.OK);
		}
		
	}
	
	@GetMapping("/findpw")
	public void findpw() {
		
	}
	
	
	
}
