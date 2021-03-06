package com.book.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class ArtBoardVO {
	
	private Long bno;
	private String categorie;
	private String region;
	private String title;
	private String content;
	private String address;
	private String writer;
	private String writerName;
	private String galleryName;
	private Date regDate;
	private Date updateDate;
	private Date startDate;
	private Date endDate;
	private Date period;
	private int likes;
	private int views;
	private String profile;
	private boolean likeClicked;

	private int replyCnt;
	private int likesCnt;
	
	private String fileName;

}
