package com.fengjie.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengjie.init.Pages;
import com.fengjie.json.RestResponse;
import com.fengjie.kit.MapCache;
import com.fengjie.kit.StringUtils;
import com.fengjie.model.entity.Comments;
import com.fengjie.model.entity.User;
import com.fengjie.service.CommentService;
import com.fengjie.service.SiteService;

@Controller
@RequestMapping("/admin/comments")
public class CommentController {
	@Autowired
	private CommentService commentService;
	@Autowired
	private SiteService siteService;
	
	
	/**
	 * 进入评论管理界面
	 * @param page
	 * @param map
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="",method=RequestMethod.GET)
	public String index(@RequestParam(defaultValue="1") int page,ModelMap map,HttpServletRequest request) throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		//下面一行代码硬编码
		int limit = 15;
		Pages pages = new Pages(siteService.getCommentsCount(user));
		pages.setPresent(page);
		pages.setLimit(limit);
		List<Comments> comments = commentService.getComments(user, pages);
		map.addAttribute("comments", comments);
		map.addAttribute("pages", pages);
		return "admin/comment_list";
	}
	
	
	@RequestMapping(value="",method=RequestMethod.POST)
	public @ResponseBody RestResponse<String> reply(int coid,String content,HttpServletRequest request) throws Exception{
		User user = (User) request.getSession().getAttribute("user");
		Comments oldComments = commentService.getCommentByCoid(coid);
		if(oldComments == null) {
			return RestResponse.fail("评论不存在");
		}
		if(!StringUtils.hasLength(content)) {
			return RestResponse.fail("请输入完整的内容");
		}
		if(content.length() > 2000) {
			return RestResponse.fail("回复不能超过2000字");
		}
		
		Comments comments = new Comments();
		comments.setAuthorId(user.getUid());
		comments.setAuthor(user.getScreenName());
		comments.setCid(oldComments.getCid());
		comments.setIp(request.getLocalAddr());
		comments.setUrl(request.getRequestURI());
		comments.setContent(content);
		comments.setEamil(user.getEmail());
		comments.setParent(coid);
		
		Integer saveComment = commentService.saveComment(comments);
		if(saveComment == 1) {
			return RestResponse.success();
		}
		
		return RestResponse.fail("数据库错误");
	}
	
	
	@RequestMapping(value="/delete")
	public @ResponseBody RestResponse<String> deleteComment(int coid) throws Exception{
		Integer infNum = commentService.deleteCommentByCoid(coid);
		if(infNum == 1) {
			MapCache.single().del("sys:statistics");
			return RestResponse.success();
		}
		return RestResponse.fail("删除失败");
	}
	
	
}
