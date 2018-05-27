package com.fengjie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.ArticleDao;
import com.fengjie.dao.LogsDao;
import com.fengjie.dao.MetasDao;
import com.fengjie.dao.SiteDao;
import com.fengjie.init.Pages;
import com.fengjie.json.RestResponse;
import com.fengjie.kit.DateKit;
import com.fengjie.kit.MapCache;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Logs;
import com.fengjie.model.entity.Metas;
import com.fengjie.model.entity.User;
import com.fengjie.model.queryVo.ContentsQueryVo;
import com.fengjie.model.queryVo.MetasQueryVo;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private LogsDao logsDao;
	@Autowired
	private MetasDao metasDao;
	
	/**
	 * 获取所有的metas(及文章类型)
	 * @return
	 * @throws Exception
	 */
	public List<Metas> getMetas(String type,int uid) throws Exception{
		MetasQueryVo metasQueryVo = new MetasQueryVo();
		Metas metas = new Metas();
		metas.setType(type);
		metas.setAuthorId(uid);
		metasQueryVo.setMetas(metas);
		return metasDao.getMetas(metasQueryVo);
	}
	
	public Integer getTotalContentsNum(User user) throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo(user,null);
		return siteDao.getContentsCount(contentsQueryVo);
	}
	
	public List<Contents> getArticleDescriptions(Pages page,User user) throws Exception{
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo(user,"post");
		contentsQueryVo.setLimit(page.getLimit());
		contentsQueryVo.setStart((page.getPresent() - 1)*page.getLimit());
		return siteDao.getArticleDescriptions(contentsQueryVo);
	}
	
	public RestResponse<Integer> saveContent(Contents content,User user,String ip) {
		//此处的log设置的有些问题
		content.setCreated(DateKit.nowUnix());
		Logs log = new Logs("发表文章", user.getUsername(), ip, user.getUid());
		Integer cid = null;
		try {
			articleDao.saveContent(content);
			logsDao.insertLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("内部错误");
		}
		cid = content.getCid();
		MapCache.single().del("sys:statistics");
		return RestResponse.success(cid);
	}
	
	public RestResponse<String> deleteArticle(int cid) {
		try {
			articleDao.deleteContent(cid);
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("内部错误");
		}
		return RestResponse.success();
	}
	
	public Contents getArticleByCid(int cid) throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo(cid);
		//只填写了cid,所以只有一个
		List<Contents> contents = siteDao.getContents(contentsQueryVo);
		return contents.get(0);
	}
	
	public RestResponse<Integer> updateArticle(Contents content,User user){
		content.setModified(DateKit.nowUnix());
		try {
			articleDao.updateContents(content);
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("内部错误");
		}
		return RestResponse.success(content.getCid());
	}
	
}
