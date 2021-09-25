package com.book.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private Integer pageNo;
	private Integer amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNo, int amount) {
		this.pageNo = pageNo;
		this.amount = amount;
	}
	
	public int getFrom() {
		return amount * (pageNo -1);
	}
	
	public String[] getTypeArray() {
		if(type == null) {
			return new String[] {};
	} else {
		String[] types = type.split("");
		return types;
		}
	}
		
}
