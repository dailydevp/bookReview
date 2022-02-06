package com.book.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.book.domain.UserVO;

public interface UserService {
	boolean insert(UserVO user);
	
	UserVO read(String name);
	
	UserVO info(long bno);
	
	UserVO viewInfo(String usermail);
	
	boolean modify(UserVO user);
	
	boolean delete(UserVO user);
	
	UserVO check(String usermail);

	UserVO dupNickCheck(String nick);
	
	UserVO checkPw(String userpw);

	boolean modify(UserVO user, String oldPassword);

	boolean delete(UserVO user, String oldPassword);
	
	boolean modifyInfo(UserVO user);
	
	boolean upload(String usermail, MultipartFile mfile);
	
	public List<UserVO> list();

	void send(String subject, String text, String from, String to);

	UserVO findmail(String phoneNo);
}
