<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="active" value="home" scope="request"></c:set>
<c:set var="title" value="个人设置" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<div class="row">

    <div class="col-sm-12">
        <h4 class="page-title">个人设置</h4>
    </div>

    <div class="col-md-6">
        <div class="panel panel-color panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">个人信息</h3>
            </div>
            <div class="panel-body">
                <form class="form-horizontal" role="form" id="user-form">
                    <div class="form-group">
                        <label class="col-md-3 control-label">账号</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" value="${user.username}" readonly disabled/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">姓名</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="screenName" placeholder="输入您的姓名"
                                   value="${user.screenName}" required aria-required="true"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">邮箱</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="email" placeholder="输入您的邮箱"
                                   value="${user.email}" required aria-required="true"/>
                        </div>
                    </div>
                    <div class="clearfix pull-right">
                        <button type="button" class="btn btn-primary waves-effect waves-light" onclick="saveSetting()">
                            保存信息
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="panel panel-color panel-danger">
            <div class="panel-heading">
                <h3 class="panel-title">修改密码</h3>
            </div>
            <div class="panel-body">
                <form class="form-horizontal" role="form" id="pwd-form">
                    <div class="form-group">
                        <label class="col-md-3 control-label">输入旧密码</label>
                        <div class="col-md-9">
                            <input type="password" class="form-control" name="old_password" required
                                   aria-required="true"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">输入新密码</label>
                        <div class="col-md-9">
                            <input type="password" name="password" id="password1" class="form-control" required
                                   aria-required="true" rangelength="[6,14]"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">确认新密码</label>
                        <div class="col-md-9">
                            <input type="password" name="repass" class="form-control" equalTo="#password1"/>
                        </div>
                    </div>
                    <div class="clearfix pull-right">
                        <button type="submit" class="btn btn-danger waves-effect waves-light">
                            设置密码
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>
        <script src="/Blog/resources/static/admin/plugins/jquery-validate/1.15.1/jquery.validate.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/jquery-validate/1.15.1/localization/messages_zh.min.js"></script>
<script type="text/javascript">
    var tale = new $.tale();
    
    /**
     *前端确保两次密码输入一致
     */

     /*function validPasswod(){
    	var password1 = $("#passowrd1").val();
    	var password2 = $("#password2").val();
    	if(password1 != null ){
    		return "";
    	}
    	
    }*/
     
    /**
     * 保存个人信息
     */
    function saveSetting() {
        var param = $('#user-form').serialize();
        tale.post({
            url : 'profile',
            data: param,
            success: function (result) {
                if(result && result.success){
                    tale.alertOk('保存成功');
                } else {
                    tale.alertError(result.payload || '保存失败');
                }
            }
        });
    }

    $('#pwd-form').validate({
        submitHandler: function (form) {
            var params = $("#pwd-form").serialize();
            tale.post({
                url : 'password',
                data: params,
                success: function (result) {
                    if(result && result.success){
                        tale.alertOk('密码修改成功');
                    } else {
                        tale.alertError(result.payload || '密码修改失败');
                    }
                }
            });
        }
    });
</script>
</body>
</html>