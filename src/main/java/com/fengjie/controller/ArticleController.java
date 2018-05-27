package com.fengjie.controller;

import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengjie.init.Pages;
import com.fengjie.json.RestResponse;
import com.fengjie.kit.MapCache;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Metas;
import com.fengjie.model.entity.User;
import com.fengjie.service.ArticleService;
import com.fengjie.service.CategoryService;

@Controller
@RequestMapping("/admin/article")
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	//只做了页面的跳转,其他的功能没有完成
	@Autowired
	private CategoryService categoryService;
	/**
	 * 文章管理列表界面
	 * @param present
	 * @param session
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="",method=RequestMethod.GET)
	public String index(@RequestParam(name="page",defaultValue="1") int present,HttpSession session,ModelMap map) throws Exception {
		User user = (User) session.getAttribute("user");
		Pages page = new Pages(articleService.getTotalContentsNum(user));
		page.setPresent(present);
		List<Contents> contents = articleService.getArticleDescriptions(page, user);
		map.addAttribute("page",page);
		map.addAttribute("contents", contents);
		return "admin/article_list";
	}
	/**
	 * 编辑已有的文章
	 * @param cid
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/{cid}",method=RequestMethod.GET)
	public String updateArticle(@PathVariable int cid,ModelMap map) throws Exception {
		Contents contents = articleService.getArticleByCid(cid);
		MapCache.single().hset(String.valueOf(cid), "tags", contents.getTags());
		//测试
		MapCache.single().hset(String.valueOf(cid), "category",contents.getCategories());
		List<Metas> categories = articleService.getMetas("category",contents.getAuthorId());
		map.addAttribute("contents", contents);
		map.addAttribute("categories", categories);
		//暂时没有这个地址
		map.addAttribute("attach_url", "");
		return "admin/article_edit";
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public @ResponseBody RestResponse<Integer> modifyArticle(@Validated Contents content,BindingResult bindingResult,HttpServletRequest request) throws Exception{
		//temp
		List<ObjectError> allErrors = bindingResult.getAllErrors();
		if(allErrors.size() > 0) {
			return RestResponse.fail(allErrors.get(0).getDefaultMessage());
		}
		User user = (User) request.getSession().getAttribute("user");
		content.setType("post");
		RestResponse<Integer> build = articleService.updateArticle(content, user);
		if(build.isSuccess()) {
			String oldTags = MapCache.single().hget(String.valueOf(content.getCid()),"tags");
			//这里存在错误
			//这里处理标签的更新
			String[] oldTagsList = MapCache.single().hget(String.valueOf(content.getCid()),"tags").toString().split(",");
			//测试
			String[] newTags = content.getTags().split(",");
			for (String name : newTags) {
				if(!oldTags.contains(name)) {
					//如果旧的标签中不包含新的标签，那么这个标签是第一次出现，新增加一个标签
					categoryService.changeMetasInContents(name, "tag", user.getUid());
				}
			}
			for (String oldName : oldTagsList) {
				if(!content.getTags().contains(oldName)) {
					Metas tag = categoryService.getMetasByNameAndType(oldName, "tag", user.getUid(), null);
					if(tag != null) {
						tag.setCount(tag.getCount() - 1);
						categoryService.updateMetas(tag);
					}
				}
			}
			MapCache.single().hset(String.valueOf(content.getCid()), "tags", content.getTags());
			//对分类进行更新，如果行的分类不是原来的分类，将原来的分类进 1，新的分类加1
			//测试
			//这里默认分类只能有一个，应该拆分之后，在做判断。
			
			String[] oldCates = MapCache.single().hget(String.valueOf(content.getCid()), "category").toString().split(",");
			String[] newCates = content.getCategories().split(",");
			
			for (String string : oldCates) {
				if(!content.getCategories().contains(string)) {
					Metas category = categoryService.getMetasByNameAndType(string, "category", user.getUid(), null);
					category.setCount(category.getCount() - 1);
					categoryService.updateMetas(category);
				}
			}
			
			for (String string : newCates) {
				if(!MapCache.single().hget(String.valueOf(content.getCid()), "category").toString().contains(string)) {
					Metas category = categoryService.getMetasByNameAndType(string, "category", user.getUid(), null);
					category.setCount(category.getCount() - 1);
					categoryService.updateMetas(category);
				}
			}
			
//			if(!MapCache.single().hget(String.valueOf(content.getCid()), "category").equals(content.getCategories())) {
//				Metas category = categoryService.getMetasByNameAndType(MapCache.single().hget(String.valueOf(content.getCid()), "category"), "category", user.getUid(), null);
//				category.setCount(category.getCount() - 1);
//				categoryService.updateMetas(category);
//				categoryService.changeMetasInContents(content.getCategories(), "category", user.getUid());
//			}
			MapCache.single().hset(String.valueOf(content.getCid()), "category", content.getCategories());
		}
		return build;
	}
	
	/**
	 * 文章编辑页面
	 * @param map
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/publish",method=RequestMethod.GET)
	public String newArticle(ModelMap map,HttpSession session) throws Exception {
		User user = (User) session.getAttribute("user");
		List<Metas> categories = articleService.getMetas("category",user.getUid());
		map.addAttribute("categories", categories);
		
		//下面代码为临时代码,后期可能修改(不给他网站的ip和端口)
		map.addAttribute("attach_url", "");
		return "admin/article_edit";
	}
	
	/**
	 * 发布文章
	 * @param content
	 * @param bindingResult
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/publish",method=RequestMethod.POST)
	public @ResponseBody RestResponse<Integer> publishArticle(@Validated Contents content,BindingResult bindingResult,HttpSession session,HttpServletRequest request) throws Exception{
		//插入数据库时,标题获取不到
		List<ObjectError> allErrors = bindingResult.getAllErrors();
		if(allErrors.size() > 0) {
			return RestResponse.fail(allErrors.get(0).getDefaultMessage());
		}
		User user = (User) session.getAttribute("user");
		//下面第一行代码为临时代码下面的post存在硬编码,以后改善
		content.setType("post");
		content.setAuthorId(user.getUid());
		//temp
		RestResponse<Integer> build = articleService.saveContent(content,user,request.getLocalAddr());
		if(build.isSuccess()) {
			String[] tags = content.getTags().split(",");
			for (String name : tags) {
				categoryService.changeMetasInContents(name,"tag",content.getAuthorId());
			}
			categoryService.changeMetasInContents(content.getCategories(), "category", content.getAuthorId());
		}
		return build;
	}
	
	/**
	 * 删除文章
	 * @param cid
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> deleteArticle(int cid) {
		RestResponse<String> build = articleService.deleteArticle(cid);
		return build;
	}
	

}
