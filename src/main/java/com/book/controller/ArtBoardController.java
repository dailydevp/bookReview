package com.book.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book.domain.ArtBoardVO;
import com.book.domain.ArtPageDTO;
import com.book.domain.Criteria;
import com.book.service.ArtBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/art")
@AllArgsConstructor
@Log4j
public class ArtBoardController {
	
	private ArtBoardService service;
	
	@RequestMapping("/list")
	public void list(@ModelAttribute("cri")Criteria cri, Model model) {
		log.info("전시리스트!");
		
		int total = service.getTotal(cri);
		
		List<ArtBoardVO> list = service.getList(cri);
		model.addAttribute("list" , list);
		model.addAttribute("pageMaker" , new ArtPageDTO(cri, total));
	}
	
	@GetMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public void write(@ModelAttribute("cri") Criteria cri) {
		// forward /WEB-INF/views/board/register.jsp
		
	}
	
	@PostMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public String write(ArtBoardVO board, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("art 글작성");
		
		board.setFileName(file.getOriginalFilename());
		
		service.write(board, file);
		
		rttr.addFlashAttribute("result", board.getBno());
		rttr.addFlashAttribute("messageTitle", "등록 성공!");
		rttr.addFlashAttribute("messageBody", board.getBno() + "번 게시물 등록 되었슴둥.");
		
		return "redirect:/board/list";
		
		
	}
	
	@RequestMapping({"/read" , "/modify"})
	public void read(@RequestParam("bno")Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("artboard read! 읽기");
		
		ArtBoardVO vo = service.read(bno);
		
		model.addAttribute("board", vo);
	}
	
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(ArtBoardVO board, Criteria cri, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("artboard_수정페이지!");
		
		boolean success = service.modify(board, file);
		
		if(success) {
			rttr.addFlashAttribute("result" , "success");
			rttr.addFlashAttribute("messageTitle", "수정 성공!");
			rttr.addFlashAttribute("messageBody","수정 되었슴둥~");
		}
		
		rttr.addAttribute("pageNo", cri.getPageNo());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect :/art/list";
	}
	
	@PostMapping("/delete")
	@PreAuthorize("principal.username == #writer")
	public String delete(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("artoard_삭제페이지!");
		boolean success = service.delete(bno);
		
		if(success) {
			rttr.addFlashAttribute("result","success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공.");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		
		rttr.addAttribute("pageNo", cri.getPageNo());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect :/board/list";
	}
	

}
