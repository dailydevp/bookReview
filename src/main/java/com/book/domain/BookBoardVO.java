package com.book.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BookBoardVO {
	
	private Long bno;
	private String categorie;
//	private String subCategorie;
	private String author;
	private String title;
	private String content;
	private String writer;
	private String writerName;
	private Date regDate;
	private Date updateDate;
	private boolean likes;
	private int views;
	private String profile;
	

	private boolean getLikeClick;
	
	private int replyCnt;
	private int likesCnt;
	
	private List<String> fileName;



}
