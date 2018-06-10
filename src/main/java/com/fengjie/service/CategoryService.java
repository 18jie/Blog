package com.fengjie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.MetasDao;
import com.fengjie.dao.SiteDao;
import com.fengjie.model.entity.Metas;
import com.fengjie.model.queryVo.MetasQueryVo;

@Service
public class CategoryService {
	@Autowired
	private SiteDao siteDao;
	@Autowired
	private MetasDao metasDao;
	
	public Integer getMetasConunt(Integer uid) throws Throwable {
		MetasQueryVo metasQueryVo = new MetasQueryVo();
		Metas metas = new Metas();
		metas.setAuthorId(uid);
		metasQueryVo.setMetas(metas);
		Integer count = siteDao.getMetasCount(metasQueryVo);
		return count;
	}
	
	public List<Metas> getMetas(String type,Integer uid) throws Exception{
		MetasQueryVo metasQueryVo = new MetasQueryVo();
		Metas meta = new Metas();
		meta.setType(type);
		meta.setAuthorId(uid);
		metasQueryVo.setMetas(meta);
		List<Metas> metas = metasDao.getMetas(metasQueryVo);
		return metas;
	}
	
	public Metas getMetasByNameAndType(String name,String type,Integer uid,Integer mid) throws Exception {
		MetasQueryVo metasQueryVo = new MetasQueryVo();
		Metas metas = new Metas();
		metas.setType(type);
		metas.setName(name);
		metas.setAuthorId(uid);
		metas.setMid(mid);
		metasQueryVo.setMetas(metas);
		//使用以上三种条件查询出来只会有一个结果或者没有
		List<Metas> oneMetas = metasDao.getMetas(metasQueryVo);
		if(oneMetas.isEmpty()) {
			return null;
		}
		return oneMetas.get(0);
	}
	
	public Integer updateMetas(Metas metas) throws Exception {
		Integer inf = metasDao.updateMetas(metas);
		return inf;
	}
	
	public Integer deleteMetasByMid(int mid) throws Exception {
		Integer inf = metasDao.deleteMetasByMid(mid);
		return inf;
	}
	
	/**
	 * 要求传过来的meta是包含uid
	 * @param metas
	 * @return
	 * @throws Exception
	 */
	public Integer insertMetas(Metas metas) throws Exception {
		Integer inf = metasDao.insertMetas(metas);
		return inf;
	}
	
	public Integer InsertNewMetas(String name,String type,Integer uid) throws Exception {
		Metas metas = new Metas();
		metas.setName(name);
		metas.setType(type);
		metas.setAuthorId(uid);
		metas.setCount(1);
		Integer inf = metasDao.insertMetas(metas);
		return inf;
	}
	
	//个人觉得将这段代码放在这里非常不好
	public boolean changeMetasInContents(String name,String type,Integer uid) throws Exception {
		//处理category和tags的分类.
			Metas metes = this.getMetasByNameAndType(name, type, uid, null);
			if(metes == null) {
				Integer inf = InsertNewMetas(name, type, uid);
				if(inf == 0) {
					return false;
				}
			}else {
				metes.setCount(metes.getCount() + 1);
				Integer inf = metasDao.updateMetas(metes);
				if(inf == 0) {
					return false;
				}
			}
		return true;
	}
	
}
