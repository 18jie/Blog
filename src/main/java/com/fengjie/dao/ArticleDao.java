package com.fengjie.dao;

import com.fengjie.model.entity.Contents;

public interface ArticleDao {
	
	
	public int saveContent(Contents content) throws Exception;
	
	public void deleteContent(int cid) throws Exception;
	
	public void updateContents(Contents content) throws Exception;

	public Integer getHits(int cid) throws Exception;
	
}
