package com.fengjie.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.UserDao;
import com.fengjie.json.RestResponse;
import com.fengjie.kit.DateKit;
import com.fengjie.kit.MD5Kit;
import com.fengjie.kit.StringUtils;
import com.fengjie.model.entity.User;
import com.fengjie.model.parm.RegistParm;

@Service
public class UserService {
	@Autowired
	private UserDao userDao;
	
	public User findUserByUsername(String username) throws Exception {
		User user = userDao.findUserByUsername(username);
		return user;
	}
	/**
	 * 检查注册账号的合法性
	 * @param registParm
	 * @return
	 * @throws Exception
	 */
	public RestResponse<String> checkAndInsertRegistParm(RegistParm registParm) throws Exception {
		int saveSignal = 0;

		if (StringUtils.hasLength(registParm.getSceenName())) {
			// 检查用户名是否重复
			/*
			 * 从后台查找所有的用户名
			 */
			if (registParm.getSceenName().contains(" ")) {
				return RestResponse.fail("用户名不能有空格");
			}

			// 一下代码仅仅做测试使用
			if (userDao.findUserBySceenName(registParm.getSceenName()) != null) {
				return RestResponse.fail("用户已被注册");
			}
			saveSignal++;
		}

		if (StringUtils.hasLength(registParm.getUsername())) {
			// 检查账号是否重复
			if (registParm.getUsername().contains(" ")) {
				return RestResponse.fail("账号不能含空格");
			}

			// 一下代码仅仅做测试使用
			if (userDao.findUserByUsername(registParm.getUsername()) != null) {
				return RestResponse.fail("账号已被注册");
			}
			saveSignal++;
		}

		if (StringUtils.hasLength(registParm.getPassword1())) {
			if (registParm.getPassword1().contains(" ")) {
				return RestResponse.fail("密码中不能有空格");
			}
			saveSignal++;
		}

		if (StringUtils.hasLength(registParm.getPassword2())) {
			if (registParm.getPassword2().contains(" ")) {
				return RestResponse.fail("密码中不能有空格");
			}
			saveSignal++;
		}

		if (StringUtils.hasLength(registParm.getPassword2()) && StringUtils.hasLength(registParm.getPassword1())) {

			if (!registParm.getPassword1().equals(registParm.getPassword2())) {
				return RestResponse.fail("输入的密码不一致");
			}
			saveSignal++;
		}

		if (StringUtils.hasLength(registParm.getEmail())) {
			if (!StringUtils.isValidEmail(registParm.getEmail())) {
				return RestResponse.fail("非法邮箱");
			}
			saveSignal++;
		}

		if (saveSignal == 6) {
			// 获取当前的时间戳
			// 保存新注册的用户对象
			//构造一个用户对象
			User user = new User();
			user.setUsername(registParm.getUsername());
			user.setPassword(MD5Kit.string2MD5(registParm.getPassword1()));
			user.setScreenName(registParm.getSceenName());
			user.setEmail(registParm.getEmail());
			user.setCreated(DateKit.nowUnix());
			user.setActivated(DateKit.nowUnix());
			int insertId = userDao.insertUser(user);
			if(insertId <=0) {
				return RestResponse.fail("服务器内部错误");
			}
		}
		return RestResponse.success();
	}
	
	/**
	 * 修改用户基本信息
	 * @param userMessageParm
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User updateUserMessage(User user) throws Exception{
		try {
			userDao.updateUserMessage(user);
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
		User newUser = userDao.findUserByUsername(user.getUsername());
		return newUser;
	}
	/**
	 * 修改用户密码
	 * @param password
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User updateUserPassword(String password,User user) throws Exception {
		user.setPassword(password);
		try {
			userDao.updateUserPassword(user);
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
		User newUser = userDao.findUserByUsername(user.getUsername());
		return newUser;
	}
}
