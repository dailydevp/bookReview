package com.book.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BookLikesVO {

	private String usermail;
	private Long bno;
	private Long lno;
	
	private Long count;
}
