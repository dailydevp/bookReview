package com.book.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BookReplyVO {
	
	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	private Date replyDate;
	
	private String replyerName;
	

}
