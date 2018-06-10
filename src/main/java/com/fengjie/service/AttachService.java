package com.fengjie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.AttachDao;
import com.fengjie.init.Pages;
import com.fengjie.model.entity.Attach;
import com.fengjie.model.entity.User;
import com.fengjie.model.queryVo.AttachQueryVo;

@Service
public class AttachService {
	
	@Autowired
	private AttachDao attachDao;
	
	public List<Attach> getAttachs(User user,Pages page) throws Exception{
		AttachQueryVo attachQueryVo = new AttachQueryVo();
		Attach attach = new Attach();
		attach.setAuthorId(user.getUid());
		attachQueryVo.setAttach(attach);
		attachQueryVo.setStart((page.getPresent()-1) * page.getLimit());
		attachQueryVo.setLimit(page.getLimit());
		List<Attach> attachs = attachDao.getAttachs(attachQueryVo);
		return attachs;
	}
	
	public void addAttach(Attach attach) throws Exception {
		attachDao.insertAttach(attach);
	}
	
	public Attach getAttachById(User user,Integer id) throws Exception {
		AttachQueryVo attachQueryVo = new AttachQueryVo();
		Attach attach = new Attach();
		attach.setAuthorId(user.getUid());
		attach.setId(id);
		attachQueryVo.setAttach(attach);
		List<Attach> attachs = attachDao.getAttachs(attachQueryVo);
		if(attachs.size() > 0) {
			return attachs.get(0);
		}
		return null;
	}
	
	public Integer deleteAttachById(int id) throws Exception {
		Integer cloumn = attachDao.deleteAttachById(id);
		return cloumn;
	}
	
}
