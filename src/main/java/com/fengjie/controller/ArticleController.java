package com.fengjie.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fengjie.init.Pages;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Metas;
import com.fengjie.model.entity.User;
import com.fengjie.service.ArticleService;

@Controller
@RequestMapping("/admin/article")
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	//只做了页面的跳转,其他的功能没有完成
	
	/**
	 * 文章管理列表界面
	 * @param present
	 * @param session
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="",method=RequestMethod.GET)
	public String index(@RequestParam(defaultValue="1") int present,HttpSession session,ModelMap map) throws Exception {
		User user = (User) session.getAttribute("user");
		Pages page = new Pages(articleService.getTotalContentsNum(user));
		page.setPresent(present);
		List<Contents> contents = articleService.getContents(page, user);
		map.addAttribute("page",page);
		map.addAttribute("contents", contents);
		return null;
	}
	
	/**
	 * 文章发布(编辑页面)
	 * @param map
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/publish",method=RequestMethod.GET)
	public String newArticle(ModelMap map,HttpSession session) throws Exception {
		List<Metas> categories = articleService.getMetas((User)session.getAttribute("user"));
		map.addAttribute("categories", categories);
		
		//下面代码为临时代码,后期可能修改(不给他网站的ip和端口)
		map.addAttribute("attach_url", "");
		return "admin/article_edit";
	}
	

}
