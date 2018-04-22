package com.fengjie.dao;

import java.util.List;

import com.fengjie.model.entity.Metas;
import com.fengjie.model.entity.User;

public interface ArticleDao {
	
	public List<Metas> getMetas(User user) throws Exception;
	
}
