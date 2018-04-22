package com.fengjie.service;


import java.util.List;

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
	 * 获取用户的最近评论
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
	 * 获取用户最近文章
	 * @param limit
	 * @param user
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
	 * 获取用于的一些静态信息
	 * @param user
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
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents content = new Contents();
		content.setType("post");
		content.setStatus("publish");
		contentsQueryVo.setContents(content);
		Integer articles = siteDao.getContentsCount(contentsQueryVo);
		//统计文章所需的页数
		Integer pages = articles/10;
		//统计用户所收到的所有评论
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comment = new Comments();
		comment.setOwnerId(user.getUid());
		commentsQueryVo.setComments(comment);
		Integer comments = siteDao.getCommentsCount(commentsQueryVo);
		//统计用户所有的附件数
		AttachQueryVo attachQueryVo = new AttachQueryVo();
		Attach attach = new Attach();
		attach.setAuthorId(user.getUid());
		attachQueryVo.setAttach(attach);
		Integer attachs = siteDao.getAttachCount(attachQueryVo);
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
	
	
	
}
