<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 上午11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="header.jsp"/>
<c:set var="title" value="主题"/>
<c:set var="active" value="themes"/>
<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">主题管理</h4>
    </div>
    <div class="col-md-12">
        <c:forEach var="theme" items="${themes}">
        <div class="col-md-3 text-center m-t-10">
            <img class="attach-img bx-shadow" src="/Blog/resources/static/templates/img/screenshot.png" width="200" height="200" title="${theme.name}"/>
            <div class="clearfix m-t-10">
                主题：<span>${theme.name}</span> <c:if test="${theme.name == current_theme}"> <mark>（当前主题）</mark> </c:if>
            </div>
            <div class="clearfix m-t-10">
                <c:if test="${theme.name == current_theme && theme.hasSetting}">
                <a class="btn btn-info" href="/Blog/admin/themes/setting"><span>主题设置</span></a>
                </c:if>
                <c:if test="${theme.name != current_theme}">
                <button onclick="activeTheme('${theme.name}');" type="button" class="btn btn-danger btn-sm waves-effect waves-light m-t-5">
                    <i class="fa fa-check-circle"></i> <span>启用该主题</span>
                </button>
                </c:if>
            </div>
        </div>
        </c:forEach>
    </div>
</div>
<c:import url="footer.html"/>
<script type="text/javascript">

    var tale = new $.tale();

    /**
     * 启用主题
     * @param themeName
     */
    function activeTheme(themeName) {
        tale.alertConfirm({
            title:'确定启用该主题吗?',
            then: function () {
                tale.post({
                    url : 'active',
                    data: {site_theme: themeName},
                    success: function (result) {
                        if(result && result.success){
                            tale.alertOkAndReload('主题启用成功');
                        } else {
                            tale.alertError(result.msg || '主题启用失败');
                        }
                    }
                });
            }
        });
    }

</script>
</body>
</html>
