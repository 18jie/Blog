package com.fengjie.dao;

import java.util.List;

import com.fengjie.model.entity.Comments;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.queryVo.AttachQueryVo;
import com.fengjie.model.queryVo.CommentsQueryVo;
import com.fengjie.model.queryVo.ContentsQueryVo;
import com.fengjie.model.queryVo.MetasQueryVo;

public interface SiteDao {
	//有关于comments的sql
	public List<Comments> getComments(CommentsQueryVo commentsQueryVo) throws Exception;
	
	public Integer getCommentsCount(CommentsQueryVo commentsQueryVo) throws Exception;
	
	//有关于contents的sql
	public List<Contents> getContents(ContentsQueryVo contentsQueryVo) throws Exception;
	
	public Integer getContentsCount(ContentsQueryVo contentsQueryVo) throws Exception;
	
	public List<Contents> getArticleDescriptions(ContentsQueryVo contentsQueryVo) throws Exception;
	
	public List<Contents> getPageDescriptions(ContentsQueryVo contentsQueryVo) throws Exception;
	
	//有关于attach的sql
	public Integer getAttachCount(AttachQueryVo attachQueryVo) throws Exception;
	
	//有关于mates的sql
	public Integer getMetasCount(MetasQueryVo metasQueryVo) throws Exception;
	
	
}
