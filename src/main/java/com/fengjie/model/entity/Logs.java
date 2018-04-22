package com.fengjie.model.entity;

import com.fengjie.kit.DateKit;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 记录用户产生的动作
 * 登录,退出,发表文章,删除文章,回复评论,删除评论,修改密码
 * @author 丰杰
 *
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Logs {
	
    // 项目主键
    private Integer id;

    // 产生的动作
    private String action;

    // 产生的数据
    private String data;

    // 发生人id
    private Integer authorId;

    // 日志产生的ip
    private String ip;

    // 日志创建时间
    private Long created;

    public Logs(String action, String data, String ip, Integer uid) {
        this.action = action;
        this.data = data;
        this.ip = ip;
        this.authorId = uid;
        this.created = DateKit.nowUnix();
    }

}
