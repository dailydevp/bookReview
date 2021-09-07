package com.book.mapper;

import com.book.domain.AuthVO;
import com.book.domain.FileDTO;
import com.book.domain.UserVO;

public interface UserMapper {

	public int insert(UserVO user);
	
	public void insertAuth(AuthVO auth);
	
	public UserVO read(String email);
	
	public int update(UserVO user);
	
	public int delete(UserVO user);
	
	public UserVO check(String email);
	
	public UserVO dupNickCheck(String nick);
	
	public int upload(FileDTO file);
}
