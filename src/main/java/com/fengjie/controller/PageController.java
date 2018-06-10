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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengjie.json.RestResponse;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.User;
import com.fengjie.service.ArticleService;
import com.fengjie.service.PageService;

@Controller
@RequestMapping("/admin/page")
public class PageController {
	@Autowired
	private PageService pageService;
	@Autowired
	private ArticleService articleService;
	
	/**
	 * 页面列表主页
	 * @param map
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="",method=RequestMethod.GET)
	public String index(ModelMap map,HttpSession session) throws Exception {
		User user = (User) session.getAttribute("user");
		List<Contents> pages = pageService.getPageDescriptions(user);
		map.addAttribute("articles", pages);
		return "admin/page_list";
	}
	
	/**
	 * 添加新页面
	 * @return
	 */
	@RequestMapping(value="/new",method=RequestMethod.GET)
	public String newPage(ModelMap map) {
		//暂时不设attach_url
		map.addAttribute("attach_url", "");
		return "admin/page_edit";
	}
	
	/**
	 * 修改已存在的页面
	 * @param cid
	 * @param map
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/{cid}",method=RequestMethod.GET)
	public String editPage(@PathVariable int cid,ModelMap map) throws Exception {
		Contents page = pageService.getPageByCid(cid);
		map.addAttribute("contents", page);
		//暂时不给attach_url
		map.addAttribute("attach_url", "");
		return "admin/page_edit";
	}
	
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public RestResponse<String> deletePage(int cid){
		RestResponse<String> build = pageService.deletePageByCid(cid);
		return build;
	}
	
	@RequestMapping(value="/publish",method=RequestMethod.POST)
	public @ResponseBody RestResponse<Integer> publishPage(@Validated Contents content,BindingResult bindingResult,HttpServletRequest request){
		List<ObjectError> allErrors = bindingResult.getAllErrors();
		if(allErrors.size() > 0) {
			return RestResponse.fail(allErrors.get(0).getDefaultMessage());
		}
		User user = (User) request.getSession().getAttribute("user");
		//下面第一行代码为临时代码下面的post存在硬编码,以后改善
		content.setType("page");
		content.setAuthorId(user.getUid());
		//temp
		System.out.println(content);
		RestResponse<Integer> build = pageService.saveContent(content,user,request.getLocalAddr());
		return build;
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public @ResponseBody RestResponse<Integer> modifyPage(@Validated Contents content,BindingResult bindingResult,HttpServletRequest request){
		List<ObjectError> allErrors = bindingResult.getAllErrors();
		if(allErrors.size() > 0) {
			return RestResponse.fail(allErrors.get(0).getDefaultMessage());
		}
		User user = (User) request.getSession().getAttribute("user");
		content.setType("page");
		RestResponse<Integer> build = articleService.updateArticle(content, user);
		return build;
		
	}

}
