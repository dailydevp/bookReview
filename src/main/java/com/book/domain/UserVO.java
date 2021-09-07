package com.book.domain;

import lombok.Data;

@Data
public class UserVO {
	private String email;
	private String pw;
	private String nick;
	private String phoneNo;
	private String fileName;
	private boolean enabled;
}
