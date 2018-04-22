package com.fengjie.model.entity;

import lombok.Data;
/**
 * 附件
 * @author 丰杰
 *
 */
@Data
public class Attach {
	//主键
    private Integer id;
    //文件名
    private String fname;
    //文件类型
    private String ftype;
    //文件关键字
    private String fkey;
    //文件上传的用户
    private Integer authorId;
    //上传的时间
    private Integer created;

}
