package com.fengjie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.ArticleDao;
import com.fengjie.dao.LogsDao;
import com.fengjie.dao.SiteDao;
import com.fengjie.json.RestResponse;
import com.fengjie.kit.DateKit;
import com.fengjie.kit.MapCache;
import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.Logs;
import com.fengjie.model.entity.User;
import com.fengjie.model.queryVo.ContentsQueryVo;

@Service
public class PageService {
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private LogsDao logsDao;
	
	public List<Contents> getPageDescriptions(User user) throws Exception{
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo(user,"page");
		List<Contents> pages = siteDao.getPageDescriptions(contentsQueryVo);
		return pages;
	}
	
	public Contents getPageByCid(int cid) throws Exception {
		ContentsQueryVo contentsQueryVo = new ContentsQueryVo();
		Contents contents = new Contents();
		contents.setCid(cid);
		contentsQueryVo.setContents(contents);
		List<Contents> contents2 = siteDao.getContents(contentsQueryVo);
		return contents2.get(0);
	}
	
	public RestResponse<String> deletePageByCid(int cid) {
		try {
			articleDao.deleteContent(cid);
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("未知错误");
		}
		return RestResponse.success();
	}
	
	public RestResponse<Integer> saveContent(Contents content,User user,String ip) {
		//此处的log设置的有些问题
		content.setCreated(DateKit.nowUnix());
		System.out.println(content);
		Logs log = new Logs("新增页面", user.getUsername(), ip, user.getUid());
		Integer cid = null;
		try {
			articleDao.saveContent(content);
			logsDao.insertLog(log);
		} catch (Exception e) {
			e.printStackTrace();
			return RestResponse.fail("内部错误");
		}
		cid = content.getCid();
		return RestResponse.success(cid);
	}
	
}
