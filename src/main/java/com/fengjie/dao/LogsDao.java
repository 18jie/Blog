package com.fengjie.dao;


import java.util.List;

import com.fengjie.model.entity.Logs;
import com.fengjie.model.queryVo.LogsQueryVo;

public interface LogsDao {
	
	public void insertLog(Logs log) throws Exception;
	
	public List<Logs> getLosgs(LogsQueryVo logsQueryVo) throws Exception;

}
