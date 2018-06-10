package com.fengjie.model.entity;

import lombok.Data;

@Data
public class User {
	   // user表主键
    private Integer uid;

    // 用户名称
    private String username;

    // 用户密码
    private String password;

    // 用户的邮箱
    private String email;

    // 用户的主页
    private String homeUrl;

    // 用户显示的名称
    private String screenName;

    // 用户注册时的GMT unix时间戳
    private Long created;

    // 最后活动时间
    private Long activated;

    // 上次登录最后活跃时间
    private Long logged;

    // 用户组
    private String groupName;
}
