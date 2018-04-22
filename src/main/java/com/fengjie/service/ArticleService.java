package com.fengjie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.ArticleDao;
import com.fengjie.dao.SiteDao;
import com.fengjie.init.Pages;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Metas;
import com.fengjie.model.entity.User;
import com.fengjie.model.queryVo.ContentsQueryVo;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private SiteDao siteDao;
	
	/**
	 * 获取所有的metas(及文章类型)
	 * @return
	 * @throws Exception
	 */
	public List<Metas> getMetas(User user) throws Exception{
		return articleDao.getMetas(user);
	}
	
	public Integer getTotalContentsNum(User user) throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo(user);
		return siteDao.getContentsCount(contentsQueryVo);
	}
	
	public List<Contents> getContents(Pages page,User user) throws Exception{
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo(user);
		contentsQueryVo.setLimit(page.getLimit());
		contentsQueryVo.setStart((page.getPresent() - 1)*page.getLimit());
		return siteDao.getContents(contentsQueryVo);
	}

}
