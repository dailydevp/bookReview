package com.book.domain;


import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	private String usermail;
	private String userpw;
	private String nick;
	private String phoneNo;
	private Date regdate;
	private String fileName;
	private boolean enabled;
	
	private List<AuthVO> authList;


}
