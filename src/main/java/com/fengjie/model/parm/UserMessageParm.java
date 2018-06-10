package com.fengjie.model.parm;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;
@Data
public class UserMessageParm {
	@NotEmpty(message="用户名不能为空")
	private String screenName;
	
	@Email(message="请输入正确的email地址")
	private String email;

}
