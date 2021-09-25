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

import com.book.domain.ArtReplyVO;
import com.book.domain.BookReplyVO;
import com.book.service.ArtReplyService;
import com.book.service.BookReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/artreplies")
@Log4j
@AllArgsConstructor
public class ArtReplyController {

	private ArtReplyService service;
	
	@PostMapping("/new")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> add(@RequestBody ArtReplyVO vo){
		log.info("새 댓글작성");
		
		int cnt = service.write(vo);
		
		if(cnt == 1) {
			return new ResponseEntity<String> ("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/pages/{bno}")
	public List<ArtReplyVO> getList(@PathVariable("bno") Long bno){
		return service.getList(bno);
	}
	
	@GetMapping("/{rno}")
	public ArtReplyVO get(@PathVariable Long rno) {
		return service.read(rno);
	}
	
	@DeleteMapping("/{rno}")
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> delete(@PathVariable Long rno, @RequestBody ArtReplyVO vo){
		
		int cnt = service.delete(rno);
		
		if (cnt == 1) {
			return new ResponseEntity<String> ("success" , HttpStatus.OK);
		}else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value="/{rno}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> modify(@RequestBody ArtReplyVO vo, @PathVariable Long rno){
		int cnt = service.modify(vo);
		
		if(cnt == 1) {
			return new ResponseEntity<String> ("success" , HttpStatus.OK);
		}else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
}
