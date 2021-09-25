package com.book.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.book.domain.BookReplyVO;
import com.book.service.BookReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping("/replies")
@Log4j
@AllArgsConstructor
public class BookReplyController {
	
	private BookReplyService service;
	
	@PostMapping("/new")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> add(@RequestBody BookReplyVO vo){
		log.info("새 댓글작성");
		
		int cnt = service.write(vo);
		
		if(cnt == 1) {
			return new ResponseEntity<String> ("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/pages/{bno}")
	public List<BookReplyVO> getList(@PathVariable("bno") Long bno){
		return service.getList(bno);
	}
	
	@GetMapping("/{rno}")
	public BookReplyVO get(@PathVariable Long rno) {
		return service.read(rno);
	}
	
	@DeleteMapping("/{rno}")
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> delete(@PathVariable Long rno, @RequestBody BookReplyVO vo){
		
		int cnt = service.delete(rno);
		
		if (cnt == 1) {
			return new ResponseEntity<String> ("success" , HttpStatus.OK);
		}else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value="/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> modify(@RequestBody BookReplyVO vo, @PathVariable Long rno){
		int cnt = service.modify(vo);
		
		if(cnt == 1) {
			return new ResponseEntity<String> ("success" , HttpStatus.OK);
		}else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
