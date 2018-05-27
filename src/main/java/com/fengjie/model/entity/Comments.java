package com.fengjie.model.entity;


import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.URL;

import lombok.Data;

@Data
public class Comments {
	//comment表主键
	private Integer coid;
	
	//post表主键,关联字段
	private Integer cid;
	
	//评论是生成的GMT unix时间戳
	private Long created;
	
	@NotEmpty
	@Length(max=30,message="名称过长")
	private String author;
	
	@NotEmpty
	@Email(message="请输入正确的邮箱格式")
	private String eamil;
	
	//评论所属用户id
	private Integer authorId;
	
	//评论所属内容作者id
	private Integer ownerId;
	
	@URL
	private String url;
	
	//评论者ip地址
	private String ip;
	
	//评论者客户端
	private String agent;
	
	 // 评论内容
    @NotEmpty(message = "请输入评论内容")
    @Length(max = 2000, message = "请输入%d个字符以内的评论")
    private String content;

    // 评论类型
    private String type;

    // 评论状态
    private String status;

    // 父级评论
    private Integer parent;
}
