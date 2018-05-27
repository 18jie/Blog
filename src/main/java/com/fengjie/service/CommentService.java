package com.fengjie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.CommentDao;
import com.fengjie.dao.SiteDao;
import com.fengjie.init.Pages;
import com.fengjie.model.entity.Comments;
import com.fengjie.model.entity.User;
import com.fengjie.model.queryVo.CommentsQueryVo;

@Service
public class CommentService {
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private CommentDao commentDao;
	
	public List<Comments> getComments(User user,Pages page) throws Exception {
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comment = new Comments();
		comment.setOwnerId(user.getUid());
		commentsQueryVo.setComments(comment);
		commentsQueryVo.setLimit(page.getLimit());
		commentsQueryVo.setStart((page.getPresent() - 1) * page.getLimit()); 
		List<Comments> comments = siteDao.getComments(commentsQueryVo);
		return comments;
	}
	
	public Integer deleteCommentByCoid(int coid) throws Exception {
		Integer infNum = commentDao.deleteCommentByCoid(coid);
		return infNum;
	}
	
	public Integer getCommentNumByCoid(int coid) throws Exception {
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comment = new Comments();
		comment.setCoid(coid);
		Integer commentsCount = siteDao.getCommentsCount(commentsQueryVo);
		return commentsCount;
	}
	
	public Comments getCommentByCoid(int coid) throws Exception {
		CommentsQueryVo commentsQueryVo = new CommentsQueryVo();
		Comments comments = new Comments();
		comments.setCoid(coid);
		commentsQueryVo.setComments(comments);
		//只会查找出一个
		List<Comments> comments2 = siteDao.getComments(commentsQueryVo);
		return comments2.get(0);
	}
	
	public Integer saveComment(Comments comment) throws Exception {
		Integer addComments = commentDao.addComments(comment);
		return addComments;
	}
	
}
