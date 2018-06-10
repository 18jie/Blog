package com.fengjie.dao;

import java.util.List;

import com.fengjie.model.entity.Attach;
import com.fengjie.model.queryVo.AttachQueryVo;

public interface AttachDao {
	
	public List<Attach> getAttachs(AttachQueryVo attachQueryVo) throws Exception;
	
	public void insertAttach(Attach attach) throws Exception;
	
	public Integer deleteAttachById(int id) throws Exception;

}
