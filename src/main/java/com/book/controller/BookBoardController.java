package com.book.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.book.domain.ArtBoardVO;
import com.book.domain.ArtPageDTO;
import com.book.domain.BookBoardVO;
import com.book.domain.Criteria;
import com.book.domain.PageDTO;
import com.book.service.ArtBoardService;
import com.book.service.BookBoardSerive;
import com.book.service.BookLikesService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BookBoardController {
	

	@Setter(onMethod_=@Autowired)
	private BookBoardSerive service;
	
	@Setter(onMethod_=@Autowired)
	private BookLikesService lservice;
	

	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri")Criteria cri, Model model, Principal principal) {
		log.info("책리스트!");
		
		int total = service.getTotal(cri);
		
		List<BookBoardVO> list = service.getList(cri);
		
		model.addAttribute("list" , list);
		model.addAttribute("pageMaker" , new PageDTO(cri, total));
		
		log.info(principal);
		
		if (principal != null) {
			List<Long> likesList = lservice.getList(principal.getName());
		
			
			log.info(likesList);
			
			
			for (BookBoardVO vo : list) {
				if(likesList.contains(vo.getBno())) {
				log.info(vo);
				vo.setGetLikeClick(true);
			
			}
		}
	}
}	

	@GetMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public void write(@ModelAttribute("cri") Criteria cri) {
	
		
	}
	
	@GetMapping("/write2")
	//@PreAuthorize("isAuthenticated()")
	public void write2(@ModelAttribute("cri") Criteria cri) {
	
		
	}
	
	@PostMapping("/write2")

	public String write2(BookBoardVO board, @RequestParam("file") MultipartFile[] file, RedirectAttributes rttr) {
		log.info("책 글작성22222");

	//	service.write(board, file);
		
		rttr.addFlashAttribute("result", board.getBno());
		rttr.addFlashAttribute("messageTitle", "등록 성공!");
		rttr.addFlashAttribute("messageBody", board.getBno() + "번 게시물이 등록 되었습니다.");
		
		return "redirect:/board/list";
		
		
	}
	
	@PostMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public String write(BookBoardVO board, @RequestParam("file") MultipartFile[] file, RedirectAttributes rttr) {
		log.info("책 글작성");

		service.write(board, file);
		
		rttr.addFlashAttribute("result", board.getBno());
		rttr.addFlashAttribute("messageTitle", "등록 성공!");
		rttr.addFlashAttribute("messageBody", board.getBno() + "번 게시물이 등록 되었습니다.");
		
		return "redirect:/board/list";
		
		
	}
	
//	@PatchMapping("/modifyDemo")
//	public void dome(@RequestBody Long bno, @ModelAttribute("cri"))
	
	@GetMapping({"/read","/modify"})
	public void read(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model, Principal principal) {
		log.info("board read! 읽기");
		log.info(bno);
		log.info(model);

		
		BookBoardVO vo = service.read(bno);
		
		model.addAttribute("book" , vo);
		
		log.info(principal);
		
		if(principal != null) {
			Long Clicked = lservice.getLikeClick(principal.getName(), vo.getBno());
			Long one = 1L;
			if(one.equals(Clicked)) {
				vo.setGetLikeClick(true);
				log.info(vo);
				service.likes(bno);
			}
		}
		
		model.addAttribute("board", vo);
		
		service.views(bno);
	}
	


	@PostMapping("/modify")
	@PreAuthorize("principal.username == #board.writer")
	public String modify(BookBoardVO board, Criteria cri, @RequestParam("file") MultipartFile[] file, RedirectAttributes rttr) {
		log.info("board_수정페이지!");

		
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
		
		return "redirect:/board/list";
	}

	
	@PostMapping("/delete")
	@PreAuthorize("principal.username == #writer")
	public String delete(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("board_삭제페이지!");
		log.info("delete" + bno);
		boolean success = service.delete(bno);
		
		if(success) {
			rttr.addFlashAttribute("result","success");
			rttr.addFlashAttribute("messageTitle", "삭제 성공.");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}else {
			rttr.addFlashAttribute("result","fail");
			rttr.addFlashAttribute("messageTitle", "삭제 실패.");
			rttr.addFlashAttribute("messageBody", "삭제 실패 했습니다.");
		}
		
		rttr.addAttribute("pageNo", cri.getPageNo());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	

}
