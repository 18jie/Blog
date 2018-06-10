package com.fengjie.model.dto;

import lombok.Data;
/**
 * 后台统计对象
 * @author 丰杰
 *
 */
@Data
public class Statistics {
	/**
	 * 在原程序中,他将有些内容放在了缓存中.
	 */
    // 文章数
    private long articles;
    // 页面数
    private long pages;
    // 评论数
    private long comments;
    // 分类数
    private long categories;
    // 标签数
    private long tags;
    // 附件数
    private long attachs;

}
