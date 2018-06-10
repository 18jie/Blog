package com.fengjie.dao;

import java.util.List;

import com.fengjie.model.entity.Metas;
import com.fengjie.model.queryVo.MetasQueryVo;

public interface MetasDao {
	
	public List<Metas> getMetas(MetasQueryVo metasQueryVo) throws Exception;
	
	public Integer insertMetas(Metas metas) throws Exception;
	
	public Integer updateMetas(Metas metas)throws Exception;
	
	public Integer deleteMetasByMid(int mid) throws Exception;

}
