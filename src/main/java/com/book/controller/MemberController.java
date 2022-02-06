package com.book.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book.domain.AuthVO;
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
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<UserVO> list = service.list();

		model.addAttribute("list", list);
		return "/member/list";
	}
	
	
	@RequestMapping("/changePw")
	public void changePw() {
		
	}
	
	@RequestMapping("/facebook")
	public void facebook() {
		
	}
	
	@RequestMapping("/userinfo")
	//@PreAuthorize("isAuthenticated()")
	public void userinfo(@RequestParam("bno") Long bno ,Criteria cri, Principal principal, Model model) {
		log.info("userInfo");
		UserVO users = service.info(bno);
		
		model.addAttribute("users", users);
	}
	
	@GetMapping("/viewInfo")
	public void viewInfo(Criteria cri, Principal principal, Model model) {
		log.info("남이 보는 유저");
		UserVO users = service.read(principal.getName());
		
		model.addAttribute("users", users);
	}

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
		log.info(user);
		log.info(oldPassword);
		log.info(user.getUserpw());
		
		
		boolean success = service.modify(user, oldPassword);
		
		if(success) {
			rttr.addAttribute("status", "ok");
			
			CustomUser mem = (CustomUser) auth.getPrincipal();
			mem.setUser(user);
		
		}else {
			rttr.addAttribute("status","fail");
		}
		return "redirect:/member/myinfo";
		
	}
	
	
	
	
	@PostMapping("/delete")
	@PreAuthorize("principal.username == #user.usermail")
	public String delete(UserVO user, RedirectAttributes rttr, HttpServletRequest req, String oldPassword) throws ServletException{
		log.info(user);
		log.info(user.getUserpw());
		log.info(oldPassword);
		
		boolean success = service.delete(user, oldPassword);
		
		if(success) {
			req.logout();
			return "redirect:/member/goodbye";
		}else {
			rttr.addAttribute("status", "fail");
			return "redirect:/member/myinfo";
		}
	}
	
	@RequestMapping("/goodbye")
	public void goodbye() {
		
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
	@PreAuthorize("principal.username == #vo.usermail")
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
	
	@PostMapping("/findpw")
	public String findpws(HttpSession session, @RequestParam String useremail) {
		UserVO user = service.check(useremail);
	
		if(user != null && user.getUsermail().equals(useremail)) {
					int ranNo = (int)(Math.random() * (99999-10000 + 1)) + 10000;
					String tempPw = String.valueOf(ranNo);
					user.setUserpw(tempPw);
					service.modify(user);
					
					String subject = "임시 비밀 번호 발급 안내";
					StringBuilder bds = new StringBuilder();
					bds.append("임시 비밀번호는" + tempPw + "입니다.");
					service.send(subject, bds.toString(),"testaddr67@gmail.com", useremail);
		}
		return "redirect: ${appRoot}/member/findpw";
	}
	
	@GetMapping("/findid")
	public void findid() {
	}
	
	@GetMapping("/findmail")
	@ResponseBody
	public ResponseEntity<String[]> findid(String phoneNo, RedirectAttributes rttr) {
		log.info("find id");
		
		UserVO user = service.findmail(phoneNo);
		
		if(user == null) {
			return new ResponseEntity<> (new String[] {"fail", ""}, HttpStatus.OK);
		}else {
			return new ResponseEntity<> (new String[] {"exist", user.getUsermail()}, HttpStatus.OK);
		}
	}
	
	


	@PostMapping("/profileUpload")
	@PreAuthorize("principal.username == #usermail")
	public String profileUpload(String usermail, @RequestParam("file") MultipartFile profile) {
		log.info("프로필 사진명 :" + profile.getOriginalFilename());
		
		service.upload(usermail, profile);
		
		log.info(profile);
		
		return "redirect:/member/myinfo";
	}
	
	
	
}
