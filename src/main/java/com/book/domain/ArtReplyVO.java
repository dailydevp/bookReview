package com.book.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ArtReplyVO {
	private Long rno;
	private Long bno;
	private String reply;
	private String replyer;
	private Date regDate;
	private Date updateDate;
	private Long likes;
	private String replyerName;
	

}
