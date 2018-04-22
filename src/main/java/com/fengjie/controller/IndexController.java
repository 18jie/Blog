package com.fengjie.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengjie.json.RestResponse;
import com.fengjie.kit.MD5Kit;
import com.fengjie.kit.StringUtils;
import com.fengjie.model.dto.Statistics;
import com.fengjie.model.entity.Comments;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Logs;
import com.fengjie.model.entity.User;
import com.fengjie.model.parm.UserMessageParm;
import com.fengjie.service.LogsService;
import com.fengjie.service.SiteService;
import com.fengjie.service.UserService;

/**
 * 站点service
 * 
 * @author 丰杰
 *
 */
@Controller
@RequestMapping("/admin")
public class IndexController {
	@Autowired
	private SiteService siteService;
	@Autowired
	private LogsService logsService;
	@Autowired
	private UserService userService;

	/**
	 * 进入后台(默认)主界面,显示一些基本信息
	 * 
	 * @param map
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(ModelMap map, HttpSession session) throws Exception {
		User user = (User) session.getAttribute("user");
		List<Comments> comments = siteService.getRecentComments(5, user);
		List<Contents> contents = siteService.getRecentContents(5, user);
		Statistics statistics = siteService.getStatistics(user);

		List<Logs> logs = logsService.getRecentLogs(10, user);

		map.addAttribute("has_sub", "");
		map.addAttribute("logs", logs);
		map.addAttribute("statistics", statistics);
		map.addAttribute("contents", contents);
		map.addAttribute("comments", comments);

		return "admin/index";
	}

	/**
	 * 个人设置页面
	 */
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String profile() {
		// 不用向页面中发送信息,用户信息保存到了session中
		return "admin/profile";
	}
	
	/**
	 * 修改用户基本信息
	 * @param userMessageParm
	 * @param bindingResult
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public @ResponseBody RestResponse<String> profile(@Validated UserMessageParm userMessageParm,
			BindingResult bindingResult, HttpSession session,HttpServletRequest request) throws Exception {
		List<ObjectError> allErrors = bindingResult.getAllErrors();
		if (allErrors.size() == 0) {
			User user = (User) session.getAttribute("user");
			user.setScreenName(userMessageParm.getScreenName());
			user.setEmail(userMessageParm.getEmail());
			User newUser = userService.updateUserMessage(user);
			if (newUser != null) {
				session.setAttribute("user", newUser);
				Logs log = new Logs("修改信息", newUser.getUsername(),request.getLocalAddr() , user.getUid());
				logsService.addLog(log);
				return RestResponse.success("修改成功");
			}
			return RestResponse.fail("修改失败(未知)");
		}
		return RestResponse.fail(allErrors.get(0).getDefaultMessage());
	}
	
	/**
	 * 修改用户密码
	 * @param oldPassword
	 * @param password1
	 * @param password2
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/password",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> password(@RequestParam("old_password") String oldPassword,String password1,String password2,HttpSession session) throws Exception{
		User user = (User) session.getAttribute("user");
		if(user.getPassword().equals(MD5Kit.string2MD5(oldPassword))) {
			if(StringUtils.hasLength(password1) && StringUtils.hasLength(password2)) {
				if(password1.equals(password2)) {
					User newUser = userService.updateUserPassword(password1, user);
					if(newUser != null) {
						session.setAttribute("user", user);
						return RestResponse.fail("修改成功");
					}
					return RestResponse.fail("未知错误");
				}
				return RestResponse.fail("两次输入不一致");
			}
			return RestResponse.fail("新密码不能为空");
		}
		return RestResponse.fail("密码错误");
	}
	
	//还有关于网站的设置没有做
	
}
