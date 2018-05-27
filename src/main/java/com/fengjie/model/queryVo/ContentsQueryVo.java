package com.fengjie.model.queryVo;

import com.fengjie.model.entity.Contents;
import com.fengjie.model.entity.User;

import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
public class ContentsQueryVo {
	
	public ContentsQueryVo(User user,String type) {
		Contents contents = new Contents();
		contents.setAuthorId(user.getUid());
		contents.setType(type);
		this.contents = contents;
	}
	
	public ContentsQueryVo(int cid) {
		Contents contents = new Contents();
		contents.setCid(cid);
		this.contents = contents;
	}
	
	private Contents contents;
	
	private Integer limit;
	
	private Integer start;

}
