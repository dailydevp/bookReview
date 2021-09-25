package com.book.service;

import org.springframework.web.multipart.MultipartFile;

import com.book.domain.UserVO;

public interface UserService {
	boolean insert(UserVO user);
	
	UserVO read(String name);
	
	boolean modify(UserVO user);
	
	boolean delete(UserVO user);
	
	UserVO check(String usermail);

	UserVO dupNickCheck(String nick);
	
	UserVO checkPw(String userpw);

	boolean modify(UserVO user, String oldPassword);

	boolean delete(UserVO user, String oldPassword);
	
	boolean modifyInfo(UserVO user);
	
	boolean upload(String usermail, MultipartFile mfile);
	
}
