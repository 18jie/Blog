package com.fengjie.service;


import java.util.List;

import com.fengjie.init.Pages;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.SiteDao;
import com.fengjie.kit.MapCache;
import com.fengjie.model.dto.Statistics;
import com.fengjie.model.entity.Attach;
import com.fengjie.model.entity.Comments;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.User;
import com.fengjie.model.queryVo.AttachQueryVo;
import com.fengjie.model.queryVo.CommentsQueryVo;
import com.fengjie.model.queryVo.ContentsQueryVo;

@Service
public class SiteService {
	@Autowired
	private SiteDao siteDao;
	/**
	 * 获取用户的最近评论,提供给后台使用
	 * @param limit
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public List<Comments> getRecentComments(int limit,User user) throws Exception{
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comment = new Comments();
		comment.setOwnerId(user.getUid());
		commentsQueryVo.setComments(comment);
		commentsQueryVo.setLimit(limit > 10? 10 : limit);
		List<Comments> comments = siteDao.getComments(commentsQueryVo);
		return comments;
	}

	/**
	 * 获取最近的评论信息，供前台使用
	 * @param limit 限制个数
	 * @return
	 * @throws Exception
	 */
	public List<Comments> getRecentComments(int limit) throws Exception {
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comment = new Comments();
		commentsQueryVo.setComments(comment);
		commentsQueryVo.setLimit(limit > 10? 10 : limit);
		List<Comments> comments = siteDao.getComments(commentsQueryVo);
		return comments;
	}

	/**
	 * 在用户前端文章界面中显示评论信息，需要跟文章id挂钩
	 * @param page 评论当前的页数
	 * @param cid 文章的id
	 * @return
	 * @throws Exception
	 */
	public List<Comments> getComments(Pages page,int cid) throws Exception {
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comments = new Comments();
		comments.setCid(cid);
		commentsQueryVo.setLimit(page.getLimit());
		commentsQueryVo.setStart((page.getPresent()-1)*page.getLimit());
		List<Comments> comments1 = siteDao.getComments(commentsQueryVo);
		return comments1;
	}

	/**
	 * 获取用户最近文章需要用户信息，供后台使用
	 * @param limit 限制个数
	 * @param user 用户
	 * @return
	 * @throws Exception
	 */
	public List<Contents> getRecentContents(int limit,User user) throws Exception{
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents content = new Contents();
		content.setAuthorId(user.getUid());
		contentsQueryVo.setContents(content);
		contentsQueryVo.setLimit(limit > 10 ? 10 : limit);
		List<Contents> contents = siteDao.getContents(contentsQueryVo);
		return contents;
	}

	/**
	 * 获取最近的文章信息，同前台使用
	 * @param limit 限制个数
	 * @return
	 * @throws Exception
	 */
	public List<Contents> getRecentReleasedContents(int limit) throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents content = new Contents();
		content.setStatus("publish");
		content.setType("post");
		contentsQueryVo.setContents(content);
		contentsQueryVo.setLimit(limit > 10 ? 10 : limit);
		List<Contents> contents = siteDao.getContents(contentsQueryVo);
		return contents;
	}

	/**
	 * 获取用于的一些静态信息
	 * @param user 用户
	 * @return
	 * @throws Exception
	 */
	public Statistics getStatistics(User user) throws Exception {
		//使用单例的mapCache,系统只有一个
		MapCache mapCache = MapCache.single();
		
		Statistics statistics = mapCache.get("sys:statistics");
		if(null != statistics) {
			return statistics;
		}
		//统计用户发表文章的数量
		Integer articles = getContentsCount(user);
		//统计文章所需的页数
		Integer pages = articles/10;
		//统计用户所收到的所有评论
		Integer comments = getCommentsCount(user);
		//统计用户所有的附件数
		Integer attachs = getAttachCount(user);
		//下面两个东西,我还并不知道是什么
		Integer tags = siteDao.getMetasCount(null);
		Integer categories = tags;
		
		statistics = new Statistics();
		statistics.setArticles(articles);
		statistics.setAttachs(attachs);
		statistics.setCategories(categories);
		statistics.setComments(comments);
		statistics.setPages(pages);
		statistics.setTags(tags);
		
		mapCache.set("sys:statistics", statistics);
		
		return statistics;
	}
	
	public Integer getAttachCount(User user) throws Exception {
		AttachQueryVo attachQueryVo = new AttachQueryVo();
		Attach attach = new Attach();
		attach.setAuthorId(user.getUid());
		attachQueryVo.setAttach(attach);
		Integer attachs = siteDao.getAttachCount(attachQueryVo);
		//测试使用，查看文件数量的更新
		System.out.println(attachs);
		return attachs;
	}
	
	public Integer getCommentsCount(User user) throws Exception {
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comment = new Comments();
		comment.setOwnerId(user.getUid());
		commentsQueryVo.setComments(comment);
		Integer comments = siteDao.getCommentsCount(commentsQueryVo);
		return comments;
	}
	
	public Integer getContentsCount(User user) throws Exception{
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents content = new Contents();
		content.setType("post");
		content.setStatus("publish");
		contentsQueryVo.setContents(content);
		Integer articles = siteDao.getContentsCount(contentsQueryVo);
		return articles;
	}

	/**
	 * 提供前端用户文章显示页面使用
	 * @param cid 文章id
	 * @return
	 * @throws Exception
	 */
	public Integer getCommentsCount(int cid) throws Exception {
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comments = new Comments();
		comments.setCid(cid);
		commentsQueryVo.setComments(comments);
		Integer count = siteDao.getCommentsCount(commentsQueryVo);
		return count;
	}

	public List<Contents> getContentsByBlurry(String keyword,String type) throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents contents = new Contents();
		contents.setType("post");
		contents.setStatus("publish");
		if("search".equals(type)){
			contents.setTitle(keyword);
		}
		if("tag".equals(type)){
			contents.setTags(keyword);
		}
		if("category".equals(type)){
			contents.setCategories(keyword);
		}
		contentsQueryVo.setContents(contents);
		List<Contents> contents1 = siteDao.getContents(contentsQueryVo);
		return contents1;
	}

	public Contents getOtherPage(String slug) throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents contents = new Contents();
		contents.setSlug(slug);
		contents.setType("page");
		contents.setStatus("publish");
		contentsQueryVo.setContents(contents);
		List<Contents> contents1 = siteDao.getContents(contentsQueryVo);
		return contents1.get(0);
	}

	public List<Contents> getOtherPages() throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents contents = new Contents();
		contents.setTitle("page");
		contents.setStatus("publish");
		List<Contents> contents1 = siteDao.getContents(contentsQueryVo);
		return contents1;
	}

	
}
