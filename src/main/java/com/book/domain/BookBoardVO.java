package com.book.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BookBoardVO {
	
	private Long bno;
	private String categorie;
//	private String subCategorie;
	private String title;
	private String content;
	private String writer;
	private String writerName;
	private Date regDate;
	private Date updateDate;
	private int likes;
	private int views;
	
	private int replyCnt;
	private int likesCnt;
	
	private String fileName;

}
