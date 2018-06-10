package com.fengjie.dao;

import com.fengjie.model.entity.Comments;

public interface CommentDao {
	
	public Integer deleteCommentByCoid(int coid) throws Exception;
	
	public Integer addComments(Comments comment) throws Exception; 

}
