package com.fengjie.model.queryVo;

import com.fengjie.model.entity.Comments;

import lombok.Data;
@Data
public class CommentsQueryVo {
	
	private Comments comments;
	
	private Integer limit;
	
	private Integer start;

}
