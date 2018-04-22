package com.fengjie.model.entity;

import lombok.Data;

/**
 * 元数据
 * 1.在选择项目类型的时候用到这个(每一个metas就是一种项目类型)
 * @author 丰杰
 *
 */
@Data
public class Metas {

    // 项目主键
    private Integer mid;
    // 名称
    private String  name;
    // 项目缩略名
    private String  slug;
    // 项目类型
    private String  type;
    // 选项描述
    private String  description;
    // 项目排序
    private Integer sort;
    // 父级
    private Integer parent;
    // 文章数
    private Integer count;
	
}
