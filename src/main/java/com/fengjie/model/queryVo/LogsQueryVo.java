package com.fengjie.model.queryVo;

import com.fengjie.model.entity.Logs;

import lombok.Data;
@Data
public class LogsQueryVo {
	
	private Logs logs;
	
	//设置这个参数时,限制查询个数
	private Integer limit;

}
