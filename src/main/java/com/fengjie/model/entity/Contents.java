package com.fengjie.model.entity;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.fengjie.init.BlogConst;

import lombok.Data;
import lombok.ToString;
@Data
@ToString
public class Contents {
	// post表主键
	private Integer cid;
	// 内容标题
	@NotEmpty(message = "标题不能为空")
	@Length(max = BlogConst.MAX_TITLE_COUNT, message = "文章标题最多可以输入200个字符")
	private String title;
	// 内容缩略名
	private String slug;
	// 内容生成时的GMT unix时间戳
	private Long created;
	// 内容更改时的GMT unix时间戳
	private Long modified;
	// 内容文字
	@NotEmpty(message = "内容不能为空")
	@Length(max = BlogConst.MAX_TEXT_COUNT, message = "文章内容最多可以输入20000个字符")
	private String content;
	// 内容所属用户id
	private Integer authorId;
	// 点击次数
	private Integer hits;
	// 内容类别
	private String type;
	// 内容类型，markdown或者html
	private String fmtType;
	// 文章缩略图
	private String thumbImg;
	// 标签列表
	private String tags;
	// 分类列表
	private String categories;
	// 内容状态
	private String status;
	// 内容所属评论数
	private Integer commentsNum;
	// 是否允许评论
	private Boolean allowComment;
	// 是否允许ping
	private Boolean allowPing;
	// 允许出现在聚合中
	private Boolean allowFeed;

}
