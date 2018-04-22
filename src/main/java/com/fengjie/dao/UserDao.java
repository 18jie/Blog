package com.fengjie.dao;

import com.fengjie.model.entity.User;

public interface UserDao {
	
	public User findUserByUsername(String username) throws Exception;
	
	public User findUserBySceenName(String sceenName) throws Exception;
	
	public int insertUser(User user) throws Exception;
	
	public void updateUserMessage(User user) throws Exception;
	
	public void updateUserPassword(User user)throws Exception;

}
