package com.book.mapper;

import java.util.List;

import com.book.domain.AuthVO;
import com.book.domain.FileDTO;
import com.book.domain.UserVO;

public interface UserMapper {

	public int insert(UserVO user);
	
	public void insertAuth(AuthVO auth);
	
	public UserVO read(String usermail);
	
	public int update(UserVO user);
	
	public int updateInfo(UserVO user);
	
	public int delete(UserVO user);
	
	public int deleteAuth(UserVO user);
	
	public UserVO dupNickCheck(String nick);
	
	public int upload(FileDTO file);
	
	public UserVO checkPw(String userpw);


}
