package com.fengjie.controller;


import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengjie.json.RestResponse;
import com.fengjie.kit.DateKit;
import com.fengjie.kit.MD5Kit;
import com.fengjie.kit.MapCache;
import com.fengjie.model.entity.Logs;
import com.fengjie.model.entity.User;
import com.fengjie.model.parm.LoginParm;
import com.fengjie.model.parm.RegistParm;
import com.fengjie.service.LogsService;
import com.fengjie.service.UserService;

@Controller
@RequestMapping("/admin")
public class AuthController {
	@Autowired
	private UserService userService;
	@Autowired
	private LogsService logsService;
	
	private MapCache mapCahce = MapCache.single();
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String userLogin(ModelMap map,HttpSession sesssion) {
		Random seed = new Random();
		int random = seed.nextInt(6);
		map.addAttribute("random", random < 1 ? 1 :random);
		return "admin/login";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> doLogin(LoginParm loginParm,HttpSession session,HttpServletRequest request) throws Exception {
		Integer count = mapCahce.hget("login_error_count", loginParm.getUsername());
		User user = userService.findUserByUsername(loginParm.getUsername());
		count = count== null ? 0 :count;
		if(count >= 3) {
			return RestResponse.fail("错误超过三次,稍后再试");
		}
		if(user != null) {
			//验证密码
			if(user.getPassword().equals(MD5Kit.string2MD5(loginParm.getPassword()))) {
				user.setActivated(DateKit.nowUnix());
				session.setAttribute("user", user);
				userService.updateUserMessage(user);
				if(loginParm.getRemeberMe() != null) {
					session.setMaxInactiveInterval(864000);
				}
				mapCahce.hdel("login_error_count", loginParm.getUsername());
				Logs log = new Logs("登录成功", user.getUsername(), request.getLocalAddr(),user.getUid());
				logsService.addLog(log);
				return RestResponse.success();
			}
			count++;
			mapCahce.hset("login_error_count", loginParm.getUsername(), count);
			return RestResponse.fail("密码错误");
		}else {
			return RestResponse.fail("无此用户");
		}
	}
	
	@RequestMapping(value="/regist",method=RequestMethod.GET)
	public String regist(ModelMap map) {
		Random seed = new Random();
		int random = seed.nextInt(6);
		map.addAttribute("random", random < 1? 1 :random);
		return "admin/regist";
	}
	
	@RequestMapping(value="/regist",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> doRegist(RegistParm registParm,HttpServletRequest request) throws Exception{
		RestResponse<String> build = userService.checkAndInsertRegistParm(registParm);
		return build;
	}
	
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		//退到文章主界面(暂时没有)
		
		return "";
	}
	
	@RequestMapping(value="/test",method=RequestMethod.GET)
	public String test(ModelMap map) {
		map.addAttribute("message", "test message");
		return "test";
	}
}
