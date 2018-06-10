package com.fengjie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengjie.dao.LogsDao;
import com.fengjie.model.entity.Logs;
import com.fengjie.model.entity.User;
import com.fengjie.model.queryVo.LogsQueryVo;

/**
 * 专本记录用户的一些动作,填充logs中的数据,给用户看的记录
 * @author 丰杰
 *
 */
@Service
public class LogsService {
	@Autowired
	private LogsDao logsDao;
	
	public void addLog(Logs log) throws Exception {
		logsDao.insertLog(log);
	}
	
	public List<Logs> getRecentLogs(int limit,User user) throws Exception{
		LogsQueryVo logsQueryVo = new LogsQueryVo();
		Logs log = new Logs();
		log.setAuthorId(user.getUid());
		logsQueryVo.setLogs(log);
		logsQueryVo.setLimit(limit > 10 ? 10 : limit);
		List<Logs> logs = logsDao.getLosgs(logsQueryVo);
		return logs;
	}

}
