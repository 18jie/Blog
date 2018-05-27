package com.fengjie.dao;

import java.util.List;

import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Metas;
import com.fengjie.model.queryVo.MetasQueryVo;

public interface ArticleDao {
	
	
	public int saveContent(Contents content) throws Exception;
	
	public void deleteContent(int cid) throws Exception;
	
	public void updateContents(Contents content) throws Exception;
	
}
