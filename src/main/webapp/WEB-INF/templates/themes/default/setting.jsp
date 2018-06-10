<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 上午11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="active" value="themes" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<%--#tag layout_block("bodyContent")--%>

<div class="col-sm-12">
    <h4 class="page-title">主题设置</h4>
</div>

<form id="option-from" class="form-horizontal" role="form">
    <div class="col-md-6">
        <div class="panel panel-color panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">基本设置</h3>
            </div>
            <div class="panel-body">

                <div class="form-group">
                    <label class="col-md-3 control-label">主题LOGO</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="logo"
                               value="${options.logo == null ? '/Blog/resources/static/templates/img/logo.png': options.logo}"
                               placeholder="请输入主题LOGO外链"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">主题作者</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="writer"
                               value="${options.writer == null ? 'fengjie':options.writer}" placeholder="您的博客昵称">
                    </div>
                </div>
                <div class="clearfix pull-right">
                    <button type="button" class="btn btn-primary waves-effect waves-light"
                            onclick="saveThemeOptions('option-from')">
                        保存设置
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="col-md-6">
        <div class="panel panel-color panel-inverse">
            <div class="panel-heading">
                <h3 class="panel-title">个性化设置</h3>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">微博账号</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="weibo"
                               value="${options.weibo==null ? '':options.weibo}"
                               placeholder="微博账号，不输入则不显示">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">知乎账号</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="zhihu"
                               value="${options.zhihu==null ? '':options.zhihu}"
                               placeholder="知乎账号，不输入则不显示">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">Github账号</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="github"
                               value="${options.github==null ?'':options.github}" placeholder="Github账号，不输入则不显示">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">Twitter账号</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="twitter"
                               value="${options.twitter==null ?'':options.twitter}" placeholder="Twitter账号，不输入则不显示">
                    </div>
                </div>
                <div class="clearfix pull-right">
                    <button type="button" class="btn btn-inverse waves-effect waves-light"
                            onclick="saveThemeOptions('option-from')">
                        保存设置
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>
<script type="text/javascript">

    var tale = new $.tale();

    /**
     * 保存全局设置
     */
    function saveThemeOptions(formId) {
        var param = $('#' + formId).serialize();
        tale.post({
            url : 'setting',
            data: param,
            success: function (result) {
                if(result && result.success){
                    tale.alertOk('设置保存成功');
                } else {
                    tale.alertError(result.msg || '设置保存失败');
                }
            }
        });
    }

    /**
     * 保存个性化设置
     */
    function saveIndiviSetting() {
        var param = $('#indivi-form').serialize();
        tale.post({
            url : '/admin/setting',
            data: param,
            success: function (result) {
                if(result && result.success){
                    tale.alertOk('设置保存成功');
                } else {
                    tale.alertError(result.msg || '设置保存失败');
                }
            }
        });
    }
</script>
</body>
</html>
<%--<c:import url="/WEB-INF/templates/comm/ts_base_layout.jsp"></c:import>--%>
